function P3 = calculate3DPoint (left, right)
%     calculates the 3D World Point to a given 2D Correspondency
%     Note: The Cameraparameters are hard coded. It is neccessary to adjust
%     them when the camerasystem or settings change
   
%     Calculate disparity
    disparity = left(1) - right(1);
    
%     Calculate 3D Point
    P3 = projectDisparityTo3d(left, disparity);
    
end
