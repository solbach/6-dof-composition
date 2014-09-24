
Ileft = imread('debug/new/left-image1330526259588042021.png');
Iright = imread('debug/new/right-image1330526259588042021.png');
Iloop = imread('debug/new/left-image1330526260288039923.png');

% Iloop = imrotate(Ileft, 63,'crop');
% Iloop = imtranslate(Ileft,[0, 150, 0]);

figure(5);
imshow(Iloop);

[inlierOriginalLeft inlierOriginalRight descLeft status] = stereoMatching(Ileft, Iright);

[inlierPtsLeft, inlierPtsRight, inlierOriginalRightRed, status] = ...
            findLoopClosing(inlierOriginalLeft, inlierOriginalRight, descLeft, Iloop);
        
figure(9); showMatchedFeatures(Ileft,Iloop,inlierPtsLeft,inlierPtsRight,'montage');
        
numInlier = length(inlierPtsLeft);
11
P3 = zeros(numInlier, 3);
   for m = 1:numInlier
        pTemp = calculate3DPoint(inlierPtsLeft(m).Location, ...
                                       inlierOriginalRightRed(m).Location);
        P3(m,1) = pTemp(1);
        P3(m,2) = pTemp(2);
        P3(m,3) = pTemp(3);
   end
   
P2 = zeros(length(inlierPtsRight), 2);
    for n = 1:length(inlierPtsRight)
        ImgP = inlierPtsRight(n).Location;
        P2(n,1) = ImgP(1);
        P2(n,2) = ImgP(2);
    end

[tvec, q, rvec, numInliers] = objectPose3D2D(P3, P2);
numInliers
length(P3)

[pitchZ rollZ yawZ] = quat2angle(q, 'YXZ');
yawZ = yawZ * 180/pi;


K = [749.642742046463 * 0.5, 0.0, 539.67454188334 * 0.5; ...
           0.0, 718.738253774844 * 0.5, 410.819033898981 * 0.5; ...
           0.0, 0.0, 1.0
        ];
    
P = [663.847783169875 * 0.5, 0.0, 509.298866271973 * 0.5; ...
        0.0, 663.847783169875 * 0.5 , 384.118202209473 * 0.5; ...
        0.0, 0.0, 1.0 ];

% tVecT = [ -0.0075; 0.1971; -0.0292 ];
tVecT = [-0.0075 0.0092 -0.0026]';
tVecP2 = P * -tVecT;
tVecP = P * tvec;

J2 = imtranslate(Ileft, [tVecP(2), tVecP(1), tVecP(3)]);
J2 = imrotate(J2, yawZ,'crop');

J = imtranslate(Ileft, [tVecP2(2), tVecP2(1), tVecP2(3)]);
% J = imtranslate(Ileft, [tVecP(2)-60, tVecP(1)-30, tVecP(3)] );
J = imrotate(J,  -1.9961,'crop');

figure(3);
imshowpair(Iloop, J);

figure(4);
imshowpair(Iloop, J2);

x = [ tvec; q' ];