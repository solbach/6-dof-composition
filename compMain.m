% Main program ( or example ) to test the composition.
% initial State [ X, Y, Z, roll, pitch, yaw ]
x = [0, 0, 0, 0, 0, 0];

% Get Data
data = rosBagFileReader;

% Get groundtruth
dX   = data(:, 4);
dY   = data(:, 5);
dZ   = data(:, 6);

% Get relative motion
rX       = data(:, 47);
rY       = data(:, 48);
rZ       = data(:, 49);
rRoll    = data(:, 50);
rPitch   = data(:, 51);
rYaw     = data(:, 52);

% movements repetitions
dt = 1;
tt = 2:dt:size(dX);

cX = 0;
cY = 0;
cZ = 0;

% main loop
for t = tt
    % Get relative motion:
    
    deltaTnano = data( t, 1 ) - data( t-1, 1 );
    detaTsec   = deltaTnano / 1000000000.0;
    
    mX      = rX(t) * detaTsec;
    mY      = rY(t) * detaTsec;
    mZ      = rZ(t) * detaTsec;
    mRoll   = rRoll(t)  * detaTsec;
    mPith   = rPitch(t) * detaTsec;
    mYaw    = rYaw(t)   * detaTsec;
    
    % I.    rotate
    % measurement update (Odometry)
    y = [0, 0, 0, mRoll, mPith, mYaw];
    x = comp(x,y);
    
    % II.   translate
    % measurement update (Odometry)
    y = [mX, mY, mZ, 0, 0, 0];
    x = comp(x,y);
    
    
%     % I.    rotate
%     % measurement update (Odometry)
%     y = [0, 0, 0, rRoll(t), rPitch(t), rYaw(t)];
%     x = comp(x,y);
%     
%     % II.   translate
%     % measurement update (Odometry)
%     y = [rX(t), rY(t), rZ(t), 0, 0, 0];
%     x = comp(x,y);
    
    % III.  save data to plot them afterwards
    cX = [cX x(1)];
    cY = [cY x(2)];
    cZ = [cZ x(3)];
    
end

% plot 3D with direction
% plot groundtruth
hold on;
color = 'r';
plot_dir3(dX, dY, dZ, color);

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