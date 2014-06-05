function [inlierPtsLeft, inlierPtsRight, inlierOriginalRightUp, status] = findLoopClosing(inlierOriginalLeft, inlierOriginalRight, descLeft, I3)
% This function detects loop-closer.
% IN:  inlierOriginalLeft SURFPoints of left Image
%      inlierOriginalRight SURFPoints of right Image
%      descLeft SURF Discriptors of left Image
%      I3 Loop Closing candidate
% OUT: inlierPtsLeft if we have correspondencies between left and I3, this
%       will be set.
%      inlierPtsRight if we have correspondencies between left and I3, this
%       will be set.
%      inlierOriginalRightUp we need to update the inlier set of the right
%       stereo image as well.
%      status tells us if correspondencies have been found (0 = no error,
%       1 = input does not contain enough points, 2 = Not enough inliers
%       have been found)

    [desc3, SIFT3] = findFeature(I3);
    indexPairs = matchFeatures(descLeft, desc3, 'Prenormalized', true);
    
    %  Update both sides of stereo image!
    inlierOriginalRight = inlierOriginalRight(indexPairs(:, 1));
    inlierOriginalLeft = inlierOriginalLeft(indexPairs(:, 1));
    matchedPoints2 = SIFT3(indexPairs(:, 2));

    [Rt, inlierPtsLeft, inlierPtsRight, status] = ...
      estimateGeometricTransform(inlierOriginalLeft,matchedPoints2,'similarity');

    % Tricky part again: Update index list and discard Feature from right
    % Stereo Image...
    index = zeros(inlierPtsLeft.Count, 1);
    for i = 1:inlierPtsLeft.Count
     InL = inlierPtsLeft(i).Location;
     for j = 1:inlierOriginalLeft.Count
            MaP = inlierOriginalLeft(j).Location;
           if InL == MaP
              index(i) = j;
              break;
           end
     end    
    end
    %  Index list of all discarded Feature of the left stereo image feature set
    %  Update right stereo image feature set
    inlierOriginalRightUp = inlierOriginalRight(index);
end