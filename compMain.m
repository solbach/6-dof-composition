% Main program ( or example ) to test the composition.
% mode (1 = using velocity data, 2 = using absolute states)
mode = 1;
% initial State [ X, Y, Z, roll, pitch, yaw ]
x = [0, 0, 0, 0, 0, 0];

% Get Data
data = rosBagFileReader;

% Get groundtruth
dX   = data(:, 4);
dY   = data(:, 5);
dZ   = data(:, 6);

% Get velocity
rX       = data(:, 47);
rY       = data(:, 48);
rZ       = data(:, 49);
rRoll    = data(:, 50);
rPitch   = data(:, 51);
rYaw     = data(:, 52);

% Get absolute states
aX      = data(:, 4);
aY      = data(:, 5);
aZ      = data(:, 6);
aw      = data(:, 7);
aq1     = data(:, 8);
aq2     = data(:, 9);
aq3     = data(:, 10);

% movements repetitions
dt = 1;
tt = 2:dt:size(dX);

% tt = 2:dt:30;

cX = 0;
cY = 0;
cZ = 0;

% main loop
for t = tt
    
    if mode == 2
        % Get relative motion from absolute motion
        
        % Calculate euler angles from quaternions
        q1 = [ aw(t-1), aq1(t-1), aq2(t-1), aq3(t-1) ];
        [ a1Roll a1Pitch a1Yaw ] = quatToEuler(q1);
    
        q2 = [ aw(t), aq1(t), aq2(t), aq3(t) ];
        [ a2Roll a2Pitch a2Yaw ] = quatToEuler(q2);
    
        A1  = [ aX(t-1), aY(t-1), aZ(t-1), a1Roll, a1Pitch, a1Yaw ];
        A2  = [ aX(t), aY(t), aZ(t), a2Roll, a2Pitch, a2Yaw ];
        
%         rx = - aX(t-1) + aX(t);
%         ry = - aY(t-1) + aY(t);
%         rz = - aZ(t-1) + aZ(t);
    
        R   = relativeMotionFromAbsoluteMotion(A1, A2);
        mX      = R(1);
        mY      = R(2);
        mZ      = R(3);
        mRoll   = R(4);
        mPitch  = R(5);
        mYaw    = R(6);
        
%         mX      = rx;
%         mY      = ry;
%         mZ      = rz;
%         mRoll   = 0;
%         mPitch  = 0;
%         mYaw    = 0;
    else
        % Get relative motion from velocity:
    
        deltaTnano = data( t, 1 ) - data( t-1, 1 );
        deltaTsec   = deltaTnano / 1000000000.0;
     
        mX      = rX(t) * deltaTsec;
        mY      = rY(t) * deltaTsec;
        mZ      = rZ(t) * deltaTsec;
        mRoll   = rRoll(t)  * deltaTsec;
        mPitch  = rPitch(t) * deltaTsec;
        mYaw    = rYaw(t)   * deltaTsec;
    end
    
    % I.    transformation
    % measurement update (Odometry)
    y = [mX, mY, mZ, mRoll, mPitch, mYaw];
    x = comp(x,y);

    
    % II.  save data to plot them afterwards
    cX = [cX 1];
    cY = [cY x(2)];
    cZ = [cZ x(3)];
    
    xo = x(1) - dX(t);
    yo = x(2) - dY(t);
    zo = x(3) - dZ(t);
    
    tresh = 0.001;
    if xo > tresh | xo < -tresh | yo > tresh | yo < -tresh | zo > tresh | zo < -tresh
        t
        
        xo
        yo
        zo
        
        x(1)
        x(2)
        x(3)
        
        dX(t)
        dY(t)
        dZ(t)
        
%         return;
    end
    
end

% plot 3D with direction
% plot groundtruth
hold on;
color = 'r';
plot_dir3(cX, dY, dZ, color);

% plot calculated data
color = 'b';
plot_dir3(cX, cY, cZ, color);

hold off;

% Copyright (c) 2014, Markus Solbach
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