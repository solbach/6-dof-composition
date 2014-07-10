%% Trajectory Error between GT - Odometry and GT - EKF-Result
function [errorOdom, errorEKF] = trajectoryError(X, XOdom, tStateOdo)
% This function calculates the error between GT - Odometry and GT - EKF
% Therefore it calculates the distance to a fixed reference point. The
% distances are calculated always with correspondend points. Let ID a
% unique number to identify the same pose in all state-vectors namely GT,
% Odom and X (EKF) and IDref the overall reference ID:
% diffGT   = GT(ID)   - GT(ID)
% diffOdom = Odom(ID) - Odom(IDref)
% diffEKF  = EKF(ID) - EKF(IDref)
%   where for example GT(ID) is the norm of the 3D state (X,Y,Z)
% errorOdom = sum(sqrt(diffOdom - diffGT)^2)
% errorEKF  = sum(sqrt(diffEKF - diffGT)^2)
% INPUT  : X is the EKF updated state-vector
%          XOdom is the pure Odometry (dead reckoning)
%          tStateOdo are all state-timestamps up to time
% OUTPUT : errorOdom is the error of the Odometry
%          errorEKF is the error of tht EKF-Approach

% Get groundtruth
gt = rosBagFileReader(2);
dT   = gt( :, 1 );
dX   = gt( :, 2 );
dY   = gt( :, 3 );
dZ   = gt( :, 4 );
dq1   = gt( :, 5 );
dq2   = gt( :, 6 );
dq3   = gt( :, 7 );
dqw   = gt( :, 8 );

% Find reference Indeces
tsGTIndexA   = 0;
tsTrajIndexA = 0;
for i = 1:length(dT)
   tsGT   = dT(i);
   tsTrajIndexA = min(find( abs(tStateOdo - tsGT) < 10000));
   if(tsTrajIndexA ~= 0)
      tsGTIndexA = i;
      break;
   end
end

% Find reference States
GTA   = [ dX(tsGTIndexA); dY(tsGTIndexA); dZ(tsGTIndexA) ];
EKFA  = [ X(tsTrajIndexA*7-6); X(tsGTIndexA*7-5); X(tsGTIndexA*7-4) ];
OdomA = [ XOdom(tsTrajIndexA*7-6); XOdom(tsGTIndexA*7-5); XOdom(tsGTIndexA*7-4) ];

% Prepare error vectors. Due to this initialisation they are forced to be
% column-vetor
diffEKF_GTU  = [ 0; 0 ];
diffOdom_GTU = [ 0; 0 ];

% Find reference in the following trajectory between GT and EKF
tsGTIndexB   = 0;
tsTrajIndexB = 0;
counter = 0;
for j = tsGTIndexA:length(dT)
    tsGTIndexB = dT(j);    
    tsTrajIndexB = min(find( abs(tStateOdo - tsGTIndexB) < 100000));
%     If we found a corresponding timestamp let's compute the error
    if(tsTrajIndexB ~= 0)
        counter = counter +1;

%         I.   Calculate the difference between GT  Point A and B
        GTB = [ dX(j); dY(j); dZ(j) ];
        [ diffVecGT maxVGT normVGT] = distanceVector(GTA, GTB);
        
%         II.  Calculate the difference between EKF Corresponding Point A and B
        EKFB = [ X(tsTrajIndexB*7-6); X(tsTrajIndexB*7-5); X(tsTrajIndexB*7-4) ];
        [ diffVecEKF maxVEKF normVEKF] = distanceVector(EKFA, EKFB);

%         III.  Calculate the difference between Odom Corresponding Point A and B
        OdomB = [ XOdom(tsTrajIndexB*7-6); XOdom(tsTrajIndexB*7-5); XOdom(tsTrajIndexB*7-4) ];
        [ diffVecOdom maxVOdom normVOdom] = distanceVector(OdomA, OdomB);

%         IV.   Differences bettween each and GT
        currentDiff   = normVGT - normVEKF;
        diffEKF_GTU(counter) = sqrt( currentDiff * currentDiff );
        
        currentDiff   = normVGT - normVOdom;
        diffOdom_GTU(counter) = sqrt( currentDiff * currentDiff );
    end
end

% Build the sum of the error vectors
errorOdom = sum(diffEKF_GTU)
errorEKF  = sum(diffOdom_GTU)

end
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