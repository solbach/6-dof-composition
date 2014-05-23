function [inlierPtsLeft, inlierPtsRight, Rt] = findFeature(I1, I2)
% This function finds the correspondencies between to given images using
% SURF Features. It also filters outliers and calculates the
% Rototranslation between this images. 
% INPUT : 2 Images (from a stereo vision system)
% RETURN: feature sets of the left and right image in corresponding order

%     convert the images to grayscale images
    I1g = rgb2gray(I1);
    I2g = rgb2gray(I2);

%     find surf feature
    points1 = detectSURFFeatures(I1g);
    points2 = detectSURFFeatures(I2g);
    
%     extract features
    [f1, vpts1] = extractFeatures(I1g, points1);
    [f2, vpts2] = extractFeatures(I2g, points2);
    
%     Retrieve the locations of matched points. The SURF feature vectors are already normalized.
    indexPairs = matchFeatures(f1, f2, 'Prenormalized', true) ;
    matchedPoints1 = vpts1(indexPairs(:, 1));
    matchedPoints2 = vpts2(indexPairs(:, 2));
      
%     Exclude the outliers, and compute the transformation matrix.
    [Rt, inlierPtsLeft,inlierPtsRight] = ...
    estimateGeometricTransform(matchedPoints2,matchedPoints1,'similarity');



%     Debug output:

%     figure; showMatchedFeatures(I1g,I2g,matchedPoints1,matchedPoints2);
%     legend('matched points 1','matched points 2');
    
%     figure; showMatchedFeatures(I1g,I2g,inlierPtsLeft, ...
%                                inlierPtsRight);
%     title('Matched inlier points');
    
 end