% Main program ( or example ) to test the composition.
% initial State [ X, Y, Z, w, q1, q2, q3 ]
x    = [ 0, 0, 0, 0, 0, 0, 1 ];

hold on;

% how many iterations:
numIter = 105;

% measured displacements
xdis = -0.04634 / numIter;
ydis = 0.003 / numIter;
zdis = -0.0179 / numIter;

xcov = xdis*xdis;
ycov = ydis*ydis;
zcov = zdis*zdis;

% initial covariance
uncer = 0.0001;
cov1  = zeros( 7, 7 );
[nRows,nCols] = size(cov1);
cov1(1:(nRows+1):nRows*nCols) = uncer;
cov1(1,1) = xcov;
cov1(2,2) = ycov;
cov1(3,3) = zcov;

cov2  = zeros( 7, 7 );
[nRows,nCols] = size(cov2);
cov2(1:(nRows+1):nRows*nCols) = uncer;
cov2(1,1) = xcov;
cov2(2,2) = ycov;
cov2(3,3) = zcov;

% Get Data
data = rosBagFileReader(1);

% Get Ground Truth
gt = rosBagFileReader(2);

% IMPORTANT: 
% Due to wrong caputured files we have to change the axis here

% Get groundtruth
dX   = gt(:, 2);
dY   = gt(:, 3);
dZ   = gt(:, 4);

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
tt = 2:dt:size(aX);

% tt = 2:dt:10;
cX = 0;
cY = 0;
cZ = 0;

% main loop
for t = tt
        % Get relative motion from absolute motion
        q1 = [aw(t-1), aq1(t-1), aq2(t-1), aq3(t-1)];   
        q1 = quatNormal( q1 );
        
        q2 = [aw(t), aq1(t), aq2(t), aq3(t)];
        q2 = quatNormal( q2 );
        
        % State Vectors (x, y, z, qw, qx, qy, qz)
        A1  = [ aX(t-1), aY(t-1), aZ(t-1), q1(1), q1(2), q1(3), q1(4) ];
        A2  = [ aX(t), aY(t), aZ(t), q2(1), q2(2), q2(3), q2(4) ];
           
        [s, covR]   = relativeMotionFromAbsoluteMotionUQ(A1, cov1, A2, cov2);
        
    % I.    transformation
    % measurement update (Odometry)
    [x cov1] = compUQ(x, cov1, s, covR);
  
    % II.  save data to plot them afterwards
    cX = [cX x(1)];
    cY = [cY x(2)];
    cZ = [cZ x(3)];
        
    % III. plot error ellipsoid    
    mean = [x(1) x(2) x(3)];
    error_ellipse( cov1(1:3,1:3), mean );
    xlabel('x')
    ylabel('y')
    zlabel('z')
end

% plot 3D with direction
% plot groundtruth
color = 'r';
plot_dir3(dX, dY, dZ, color);

% plot calculated data
color = 'b';
plot_dir3(cX, cY, cZ, color);

legend('groundtruth', '' , 'calculated');

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