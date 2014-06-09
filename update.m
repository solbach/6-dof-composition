function [tvec, q, status, numInliers] = update(I1, I2, I3)
% This function implements the whoel update step for 3D EKF-SLAM
% IN:  I1 Left Stereo Image 
%      I2 Right Stereo Image 
%      I3 Loop Closing candidates
% OUT: tvec translation vector to translate from model coordinate system to the
%        camera coordinate system 
%      q quaternion to express the rotation from model coordinate system to the
%        camera coordinate system 
%      status it's set to 0 if everything is fine, otherwise no loop
%       closing could have been found
%      numInliers the number of inliers that have been used to calculate
%       the translation and rotation

% I. Find Correspondencies between Images
    [inlierOriginalLeft inlierOriginalRight descLeft status] = stereoMatching(I1, I2);
    
    if status ~= 0
        error('update:Stereo', 'Stereo Images does not fit to each other')
    end

% II. Build Correspondencies between left Stereo Image and Loop-Closing
% Candidate
    for i = 1 : length(I3)
        [inlierPtsLeft, inlierPtsRight, inlierOriginalRight, status] = findLoopClosing(inlierOriginalLeft, inlierOriginalRight, descLeft, I3);
        if (status == 0 && inlierPtsLeft.Count >= 8)
            break;
        end
%         To be deleted if we are dealing with more than one loop closing
%         candidate
        if (status ~= 0 || inlierPtsLeft.Count < 8)
            error('update:LoopClosing', 'No Loop-Closing candidate could be found')
        end
    end
    
% III. Calculate 3D Points
    P3 = zeros(inlierPtsLeft.Count, 3);
    for i = 1:inlierPtsLeft.Count
        pTemp = calculate3DPoint(inlierPtsLeft(i).Location, ...
                                 inlierOriginalRight(i).Location);
        P3(i,1) = pTemp(1);
        P3(i,2) = pTemp(2);
        P3(i,3) = pTemp(3);
    end

% IV. Compare inlier Points. They have to be the same for 3D and 2D
    P2 = zeros(inlierPtsRight.Count, 2);
    for i = 1:inlierPtsRight.Count
        ImgP = inlierPtsRight(i).Location;
        P2(i,1) = ImgP(1);
        P2(i,2) = ImgP(2);
    end

% V. Find object pose from 3D-2D point correspondences using the RANSAC scheme
    [rvec, tvec, q, numInliers] = objectPose3D2D(P3, P2);

end
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