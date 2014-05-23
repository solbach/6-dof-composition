function P3 = stereoMatching(I1, I2)
%     find correspondencies between images and calculate 3D Points
    
I1 = imread('bag/left_images_color/left-image1330526257588048935.png');
I2 = imread('bag/right_images_color/right-image1330526257588048935.png');

%     I. Correspondencies and outliers elimination 
    [inlierPtsLeft, inlierPtsRight] = findFeature(I1, I2);
    
end
