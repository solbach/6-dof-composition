% PARAM:
% loopSample -> only search every 20 Images if we can find a loop closing
loopSample = 20;

% Load all Images of the stereo vision system (left and right)
pathLeft    = 'bag/left_images_color';
pathRight   = 'bag/right_images_color';

fLeft       = imageLoader(pathLeft);
fRight      = imageLoader(pathRight);

% Load images to detect loop closing 
%  (Just to be generic: normally we would use the left images of the 
%   stereo vision system)
pathLoop    = 'bag/left_images_color';
fLoop       = imageLoader(pathLoop);

% Actually this should be done starting by the odometry and not with the
% landmarks
% and look after every Nth odometry for a fitting stereo image pair
% with loop closing
for i=1:length(fLeft)
    i
%     Try to find Loop closing candidate with a certain sampling rate
    if mod(i,loopSample) == 0  

%     Load Stereo Images from Database
        ILeft  = imread([pathLeft '/' fLeft{i}]);  
        IRight = imread([pathRight '/' fRight{i}]);  
        
%    Pass already observed Images to update function
        fCurrentLoop = fLoop(1:i-10);

        [loopClosings timestamps] = update( ILeft, IRight, fCurrentLoop, pathLoop );
        if( length( loopClosings ) >= 1 )
%             If we have at least one loop closing
%             Don't forget to safe the timestamp of the reference Image
%             (left image) at the end of the timestamp vector
            tim = fLeft{ i };
            tim = tim( 11:end-4 ); 
            timestamps = [ timestamps; tim ];
        end
    end        
end


[tvec, q, status, numInliers] = update(ILeft, IRight, ILoopClosing)

rvec = quat2dcm(q)

figure(1);
imshowpair(ILeft, ILoopClosing);

figure(2);
imshow(ILeft);

figure(3);
imshow(ILoopClosing);

figure(4);
drawAngle( acos(rvec(1,1)) );

r = quat2euler(q)

hold off;

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