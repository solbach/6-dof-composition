function [inlierPtsLeft, inlierPtsRight, inlierOriginalRight, status] = findLoopClosing(inlierOriginalLeft, inlierOriginalRight, descLeft, I3)

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
    inlierOriginalRight = inlierOriginalRight(index);
end