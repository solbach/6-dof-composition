function stereoMatching
%     find correspondencies between images and calculate 3D Points

%     Camera Parameter
%     intrinsic1 = [749.642742046463, 0.0, 539.67454188334; ...
%                     0.0, 718.738253774844, 410.819033898981; 0.0, 0.0, 1.0];
%     radial1     = [-0.305727818014552, 0.125105811097608, 0.0021235435545915]; 
%     tangential1 = [0.00101183009692414, 0.0];
%     
%     intrinsic2 = [747.473744648049, 0.0, 523.981339714942; ...
%                     0.0, 716.76909875026, 411.218247507688; 0.0, 0.0, 1.0];     
%     radial2     = [-0.312470781595577, 0.140416928438558, 0.00187045432179417]; 
%     tangential2 = [-0.000772438457736498, 0.0];
%     
%     cameraParams = cameraParameters
%     cameraParams = cameraParameters('IntrinsicMatrix', intrinsic1)
%                                     'RadialDistortion', radial1, ...
%                                     'TangentialDistortion', tangential1)
    

    IntrinsicMatrix = [715.2699   0       0;
                         0     711.5281  0;
                       565.6995  355.3466  1];
    radialDistortion = [-0.3361 0.0921];
    
%     cameraParams = cameraParameters('IntrinsicMatrix', IntrinsicMatrix, 'RadialDistortion', radialDistortion);

%     stereoParams = stereoParameters


    I1c = imread('bag/left_images_color/left-image1330526257588048935.png');
    I1 = imrotate(rgb2gray(I1c), 31);
    I2c = imread('bag/right_images_color/right-image1330526257588048935.png');
    I2 = rgb2gray(I2c);

%     find surf feature
    points1 = detectSURFFeatures(I1);
    points2 = detectSURFFeatures(I2);
    
%     extract features
    [f1, vpts1] = extractFeatures(I1, points1);
    [f2, vpts2] = extractFeatures(I2, points2);
    
%     Retrieve the locations of matched points. The SURF feature vectors are already normalized.
    indexPairs = matchFeatures(f1, f2, 'Prenormalized', true) ;
    matchedPoints1 = vpts1(indexPairs(:, 1));
    matchedPoints2 = vpts2(indexPairs(:, 2));
    
    figure; showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);
    legend('matched points 1','matched points 2');
    
%     Exclude the outliers, and compute the transformation matrix.
    [tform,inlierPtsDistorted,inlierPtsOriginal] = ...
    estimateGeometricTransform(matchedPoints2,matchedPoints1,'similarity');

    figure; showMatchedFeatures(I1,I2,inlierPtsOriginal, ...
                               inlierPtsDistorted);
    title('Matched inlier points');
    
%     Recover the original image from the distorted image.
%     outputView = imref2d(size(I1));
%     Ir = imwarp(I2, tform, 'OutputView', outputView);
%     figure; imshow(Ir); title('Recovered image');

%     Disparity
    disparityMap = disparity(I1, I2, 'BlockSize', 15,'DisparityRange', ...
                                [-6 10], 'Method','SemiGlobal');
                            
     figure; imshow(disparityMap)

end
