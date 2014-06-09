hold on;
% state vector X
X   = [0; 0; 0; 0; 0; 0; 1];

% covariance matrix C
C   = zeros( 7, 7 );

% Get information about the covariance
CRel = getCov;
% Sample Rate of plotting the ellipsoids
ellipSamp = 200;

% Get Data
data = rosBagFileReader(1);

% Get absolute states
aX      = data(:, 4);
aY      = data(:, 5);
aZ      = data(:, 6);
aw      = data(:, 7);
aq1     = data(:, 8);
aq2     = data(:, 9);
aq3     = data(:, 10);

dt = 1;
tt = 2:dt:size(aX);

% MAIN LOOP

for t = tt
% xa1 is the first absolute Pose provided by libViso
% xa2 the second
    q1 = [aw(t-1), aq1(t-1), aq2(t-1), aq3(t-1)];   
    q1 = quatNormal( q1 );
        
    q2 = [aw(t), aq1(t), aq2(t), aq3(t)];
    q2 = quatNormal( q2 );
        
%     State Vectors (x, y, z, qw, qx, qy, qz)
    xa1  = [ aX(t-1), aY(t-1), aZ(t-1), q1(1), q1(2), q1(3), q1(4) ];
    xa2  = [ aX(t), aY(t), aZ(t), q2(1), q2(2), q2(3), q2(4) ];
    
    xLast = X( ((t-2)*7)+1: (t-1)*7 );
    cLast = C( ((t-2)*7)+1: (t-1)*7, : );
    
    
    [Xnew Cnew] = prediction(xLast, cLast, xa1, xa2, CRel );

% Build the state- and covariance-Vector
    X = [ X;  Xnew ];
    C = [ C;  Cnew ];

% OPTIONAL: PLOT THE ELIPSOID
    if mod(t,ellipSamp) == 0  
        mean = [Xnew(1) Xnew(2) Xnew(3)];
        error_ellipse( Cnew(1:3,1:3), mean );
    end
end

% PLOTTING

% Plot state-vector
[cX cY cZ] = stateVectorToXYZ(X);
color = 'b';
plot_dir3(cX', cY', cZ', color);

% Plot groundtruth
% Get groundtruth
gt = rosBagFileReader(2);
dX   = gt(:, 2);
dY   = gt(:, 3);
dZ   = gt(:, 4);

color = 'r';
plot_dir3(dX, dY, dZ, color);

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