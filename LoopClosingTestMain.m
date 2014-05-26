 
I1 = imread('bag/left_images_color/left-image1330526257588048935.png');
I2 = imread('bag/right_images_color/right-image1330526257588048935.png');

% I. Find 3D Points
P3 = stereoMatching(I1, I2);

% II. Find Feature of possible Loop Closing canditate
[f, vpts] = findFeature(I1);

P2 = zeros(vpts.Count, 2);
for i = 1:vpts.Count
    ImgP = vpts(i).Location;
    P2(i,1) = ImgP(1);
    P2(i,2) = ImgP(2);
end

% III. Find object pose from 3D-2D point correspondences using the RANSAC scheme
[rvec, tvec] = objectPose3D2D(P3, P2)