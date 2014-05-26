function [inlierPtsLeft, inlierPtsRight, Rt, status] = findCorrespondencies(f1, vpts1, f2, vpts2)
% This function finds the correspondencies between given features
% It also filters outliers and calculates the
% Rototranslation between this images. 
% INPUT : 2 Feature sets (from a stereo vision system)
% RETURN: feature sets of the left and right image in corresponding order
   
%     Retrieve the locations of matched points. The SURF feature vectors are already normalized.
    indexPairs = matchFeatures(f1, f2, 'Prenormalized', true) ;
    matchedPoints1 = vpts1(indexPairs(:, 1));
    matchedPoints2 = vpts2(indexPairs(:, 2));
      
%     Exclude the outliers, and compute the transformation matrix.
    [Rt, inlierPtsLeft, inlierPtsRight, status] = ...
    estimateGeometricTransform(matchedPoints2,matchedPoints1,'similarity');

%     Debug output:

%     figure; showMatchedFeatures(I1g,I2g,matchedPoints1,matchedPoints2);
%     legend('matched points 1','matched points 2');
    
%     figure; showMatchedFeatures(I1g,I2g,inlierPtsLeft, ...
%                                inlierPtsRight);
%     title('Matched inlier points');
    
 end