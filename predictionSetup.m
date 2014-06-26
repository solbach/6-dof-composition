%% Prediction Setup
% state vector X = [ X Y Z qw qx qy qz ]
X   = [0; 0; 0; 1; 0; 0; 0];

% sampling rate of the whole algorithm
samplingRateSLAM = 20;

% how many images should be discarded for the update to not perform a loop
% closing with yourself? discards the n-th last images of the set of images
imageDiscard = 1;

% covariance matrix C
C   = zeros( 7, 7 );

% Get information about the odometry- and measurement covariance
CovRel  = getCov(samplingRateSLAM);
CovMeas = CovRel;

% sampling rate of plotting the ellipsoids
ellipSamp = 30;

% Get Data
data = rosBagFileReader(1);

% Get absolute states
aX      = data( :, 4 );
aY      = data( :, 5 );
aZ      = data( :, 6 );
aq1     = data( :, 7 );
aq2     = data( :, 8 );
aq3     = data( :, 9 );
aqw     = data( :, 10 );

% Get timestamps
tMeasureOdo = data(:, 1);

% Timestamps corresponding to elements in the state vector
tStateOdo = 0;

dt = 1;
tt = 2:dt:length( aX );

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