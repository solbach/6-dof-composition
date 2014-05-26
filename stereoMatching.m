function P3 = stereoMatching(I1, I2)
%     find correspondencies between images and calculate 3D Points

%     I. Find Feature (SURF)
    [f1, vpts1] = findFeature(I1);
    [f2, vpts2] = findFeature(I2);
    
%     II. Find Correspondencies (with outlier elimination)
    [inlierPtsLeft, inlierPtsRight] = findCorrespondencies(f1, vpts1, f2, vpts2);

%     III. Calculate 3D Point for each Correspondency
    p3 = calculate3DPoint( inlierPtsLeft(1).Location, inlierPtsRight(1).Location );
    for i = 2:inlierPtsLeft.Count
        p3 = [ p3 calculate3DPoint(inlierPtsLeft(i).Location, ...
                                   inlierPtsRight(i).Location) ];
    end

%     cv.solvePnPRansac;
end
