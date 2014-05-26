function [rvec, tvec, q] = objectPose3D2D(ObjP, ImgP)
% Find the object pose from 3D-2D point correspondences using the RANSAC scheme
% INPUT : Object Points in 3D ( Nx3 ) and Image Points in 2D ( Nx2 )
% OUTPUT: rotation matrix, translation vector and rotation as quaternion

% Camera Matrix
    K = [749.642742046463, 0.0, 539.67454188334; 0.0, 718.738253774844, 410.819033898981; 0.0, 0.0, 1.0];
    
% object pose from 3D-2D point correspondences 
% using MexOpenCV an alternative could be POSIT
% (http://www.cfar.umd.edu/~daniel/Site_2/Code.html)
    [rvec, tvec] = cv.solvePnPRansac(ObjP, ImgP, K);
    rvec = cv.Rodrigues(rvec);
    q = dcm2quat(rvec);
    
%     center = [539.67454188334, 410.819033898981];
%     focalLength = 747.473744648049;
%     [rvec, tvec] = modernPosit(ImgP, ObjP, focalLength, center)

    
%   In the quaternion representation of this work w is in the beginning
%   and not at the end.
    w = q(1);
    q(1) = q(4);
    q(4) = w;
    
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