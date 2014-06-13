%% Update Setup

% PARAM:
% loopSample -> only search every 20 Images if we can find a loop closing
loopSample = 100;

% Load all Images of the stereo vision system (left and right)
% pathLeft    = 'bag/left_images_color';
% pathRight   = 'bag/right_images_color';
pathLeft    = 'bag/testSet/left_images_color';
pathRight   = 'bag/testSet/right_images_color';

fLeft       = imageLoader(pathLeft);
fRight      = imageLoader(pathRight);

% Load images to detect loop closing 
%  (Just to be generic: normally we would use the left images of the 
%   stereo vision system)
% pathLoop    = 'bag/left_images_color';
pathLoop    = 'bag/testSet/left_images_color';
fLoop       = imageLoader(pathLoop);

% Vector to store all timestamps of one update step
timestampsLC = 0;

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