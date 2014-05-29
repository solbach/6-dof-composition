
I1 = imread('bag/left_images_color/left-image1330526257588048935.png');
I2 = imread('bag/right_images_color/right-image1330526257588048935.png');

% I. Find 3D Points
P3 = stereoMatching(I1, I2);

% II. Find Feature of possible Loop Closing canditate
I3 = I1;
angle = 33;
I3 = imrotate(I3, angle);
% % tform = maketform('affine',[1 0 0; 0 1 0; 2 3 1]);
% % I3 = imtransform(I3, tform);
[f1, vpts1] = findFeature(I3);

% III. Build Correspondencies between left Stereo Image and Loop-Closing
% Candidate
[f2, vpts2] = findFeature(I1);

status = 1;
while(status ~= 0)
%     status is bad, because no correspondencies have been found
%     If so, take the next image
   [inlierPtsLeft, inlierPtsRight, Rt, status] = findCorrespondencies(f1, vpts1, f2, vpts2) ;
end

P2 = zeros(inlierPtsLeft.Count, 2);
for i = 1:inlierPtsLeft.Count
    ImgP = inlierPtsLeft(i).Location;
    P2(i,1) = ImgP(1);
    P2(i,2) = ImgP(2);
end

% III. Find object pose from 3D-2D point correspondences using the RANSAC scheme
[rvec, tvec, q] = objectPose3D2D(P3, P2)


A = quatToMatrix(q)

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

% r =
% 
%    -2.6359
% 
% 
% p =
% 
%     0.7095
% 
% 
% y =
% 
%    -0.1069