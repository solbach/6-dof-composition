function [rvec, tvec] = objectPose3D2D(ObjP, ImgP)
% Find the object pose from 3D-2D point correspondences using the RANSAC scheme

% Camera Matrix
    K = [749.642742046463, 0.0, 539.67454188334; 0.0, 718.738253774844, 410.819033898981; 0.0, 0.0, 1.0];
    
% object pose from 3D-2D point correspondences 
% using MexOpenCV an alternative could be POSIT
% (http://www.cfar.umd.edu/~daniel/Site_2/Code.html)
    [rvec, tvec] = cv.solvePnPRansac(ObjP, ImgP, K);

 end

