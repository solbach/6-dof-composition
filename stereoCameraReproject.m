function Q = stereoCameraReproject()
%    Determine Reprojection Matrix (R)
%    From Springer Handbook of Robotics, p. 524
   
%          [ Fx 0  Cx -FxTx ]
%      K = [ 0  Fy Cy   0   ]
%          [ 0  0  1    0   ]
%  
%          [ 1  0   0   -Cx ]
%      Q = [ 0  1   0   -Cy ]
%          [ 0  0   0    Fx ]
%          [ 0  0 -1/Tx  0  ]
%      parameters are from the right camera.

    Cx = 553.634304046631;
    Cy = 411.5126953125;
    Fx = 670.44838436561;
    Tx = -79.090353246545;

    Q      = zeros(4,4);
    Q(1,1) = 1;
    Q(2,2) = 1;
    Q(1,4) = -Cx;
    Q(2,4) = -Cy;
    Q(3,4) = Fx;
    Q(4,3) = -1.0 / Tx;
    
end