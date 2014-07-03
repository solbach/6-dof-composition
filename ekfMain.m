%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% INITIALISATION

predictionSetup;
updateSetup;

percent  = 0;
XOdom    = [0; 0; 0; 1; 0; 0; 0];
xTemp    = [0; 0; 0; 1; 0; 0; 0];
cPlcHldr = zeros( 7, 7 );
tStateOdo = tMeasureOdo(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAIN LOOP
for t = tt
%%     PREDICTION STEP
% xa1 is the first absolute Pose provided by libViso
% xa2 the second
    q1 = [aqw(t-1), aq1(t-1), aq2(t-1), aq3(t-1)];   
    q1 = quatNormal( q1 );
        
    q2 = [aqw(t), aq1(t), aq2(t), aq3(t)];
    q2 = quatNormal( q2 );
        
%     State Vectors (x, y, z, qw, qx, qy, qz)
    xa1  = [ aX(t-1), aY(t-1), aZ(t-1), q1(1), q1(2), q1(3), q1(4) ];
    xa2  = [ aX(t), aY(t), aZ(t), q2(1), q2(2), q2(3), q2(4) ];
    
    predictionCounter = length( xTemp ) / 7 + 1;
    xTempLast = xTemp( ((predictionCounter-2)*7)+1: (predictionCounter-1)*7 );
    
    xTempNew = prediction( xTempLast, cPlcHldr, xa1, xa2, cPlcHldr );
    xTemp = [xTemp;  xTempNew];
        
%     Only perform state augmentation and update every n Iterations.
    if ( (mod(t, samplingRateSLAM) == 0 ) || (t >= 2080) )
        
%%     STATE AUGMENTATION STEP
        updateCounter = length( X ) / 7 + 1;
        xTempLast = xTemp( ((predictionCounter-1)*7)+1: predictionCounter*7 );
        xLast     = X( ((updateCounter-2)*7)+1: (updateCounter-1)*7 );
        cLast     = C( (updateCounter-1)*7-6:(updateCounter-1)*7, (updateCounter-1)*7-6:(updateCounter-1)*7 );

        [Xnew, Cnew, Jac1, Jac2] = composition(xLast, cLast, xTempLast, CovRel); 

%     Let the state-, covariance and timestamp-Vector grow
        X = [ X;  Xnew ];
        C = calcCov( C, Cnew, Jac1, Jac2 );  
                
%     safe timestamps of the odometry corresponding to each state
        tStateOdo = [ tStateOdo; tMeasureOdo(t) ];

%     safe the odometry for later debugging  
        xOdomLast     = XOdom( ((updateCounter-2)*7)+1: (updateCounter-1)*7 );
        [Xnew, Cnew, Jac1, Jac2] = composition(xOdomLast, cLast, xTempLast, CovRel); 
        XOdom = [XOdom, Xnew];

%     Reset temporal state variable of the prediction step
        xTemp = [0; 0; 0; 1; 0; 0; 0];
        
%%      UPDATE STEP
%     Try to find Loop closing candidate with a certain sampling rate
    if mod(t,loopSample) == 0
%     Load Stereo Images from Database 
%       ( --> corresponding to the current timestamp of the odometry)
        [fNameLeft, fNameRight, pos, status]= getStereoImageByTimestamp(...
                                                    tMeasureOdo(t), ...
                                                    fLeft, fRight);
         t                                       
%     safe fNameLeft as already observed image in a new vector
        fLoop{ end+1 } =  fNameLeft;
        
        if ( ( status == 0 ) || ( updateCounter <= imageDiscard ) )
%           if status == 0 no corresponding stereo image pair has been
%           found: skip this
        else
%           if status == 1 corresponding stereo image pair has been
%           found: look for loop closing
            ILeft  = imread([pathLeft '/' fNameLeft]);  
            IRight = imread([pathRight '/' fNameRight]); 
                    
%           Pass already observed Images to update function (discard the
%           last n (--> pos - n) )
            fCurrentLoop = fLoop(1:end-imageDiscard);
            status = 0;
            if ( false )
                [zk timestampsLC status] = update( ILeft, IRight, ...
                                                  fCurrentLoop, pathLeft );
            end
            
            if ( t == length( aX ) )
                loopref(1) = -2.5061685700299999e-02;
                loopref(2) = -5.9013884093100000e-01;
                loopref(3) = 9.8463955687999996e-02;
                loopref(4) = 8.4426161073399997e-01; 
                loopref(5) = -6.2113055901100002e-03;
                loopref(6) = -9.3214105010599999e-02;
                loopref(7) = -5.2772614389500005e-01;
               
                
%                 loopref(1) = 0.0385721300908;
%                 loopref(2) = -0.611410164052;
%                 loopref(3) = 0.299691895725;
%                 loopref(4) = 0.820155325534; 
%                 loopref(5) = 0.0645235765888;
%                 loopref(6) = -0.16744686225;
%                 loopref(7) = -0.54327110947;
                
                loopref = loopref';
                
                looppoint(1) = 0.0;
                looppoint(2) = 0.0;
                looppoint(3) = 0.0;
                looppoint(4) = 1.0;
                looppoint(5) = 0.0;
                looppoint(6) = 0.0;
                looppoint(7) = 0.0;
                
                timestampsLC = 1330526261888036013;
                timeRef = 1330526526087194920;
                status = 1;
                cova = zeros(7,7);
                zk = relativeMotionFromAbsoluteMotionUQ(loopref, cova, looppoint, cova)
            end
            
            if( status == 1 )
%             If status is equal to 1 we have at least one loop closing
%             Don't forget to safe the timestamp of the reference Image
%             (left image) at the end of the timestamp vector
%                 timeRef = str2double( fNameLeft( 11:end-4 ) );
                timestampsLC = [ timestampsLC; timeRef ];

%             Applying the Kalman-Equations

%             Calculate h1 - hn: these are the realtive motions of states
%             taken from the state-vector (state estimations) corresponding
%             to the detected loop closing. In terms of EKF this is hk. the
%             parameter zk is important to update it inside this function.
%             In case we do not have to every loop closing a corresponding
%             odometry or vice versa.
                [hk H zk numLC] = calculateHhk( X, tStateOdo, ...
                                                    timestampsLC, zk );  
                                                             
%             If number of loop closings is equal to 0 no hk had been 
%             calculated so cancel all update procedures
              if ( numLC ~= 0 )
%             perform UPDATE for all found loop closings

%             DEBUGGING ( to show loopclosings )
                [LCH LCZ XREF] = absLoopClosing(X, hk, zk);

%             I.   Innovation: yk = zk - hk
                  yk = innovation( zk, hk );

%             II.  Innovation covariance: Sk = H * C * H^T + Rk 
%                  Build covariance Rk depending on the #Loopclosings
                  Rk = buildRk( CovMeas, numLC);  
                  Sk = H * C * H' + Rk;

%             III. Kalman gain: K = C * H^T * Sk^-1
%                   K  = C * H' * inv( Sk );  0
                  K  = (C * H') / Sk;
                  
%             IV.  Update state estimate: X = X + K*yk
                lad = 0;
                if ( lad == 1 )
                  X  = X + K * yk;
                end
%             V.   update covariance estimate: C = ( 1-K*H ) * C
                  prodKH = K*H;
                  C  = ( eye( size( prodKH ) ) - prodKH ) * C;
%                   t
%                   C2 = C;
%                   C2 = C2 / max( max( C2 ) );
%                   figure(5);
%                   imshow( C2 );
              end
              numLC
              plotEKF;
%               pause(0.3);
             end
          end
       end 
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT EVERYTHING
plotEKF;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SHUTTING DOWN MATLAB
% clearMATLAB;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Copyright (c) 2014, Markus Solbach
% All rights reserved.

% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:

%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in
%       the documentation and/or other materials provided with the distribution

% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.