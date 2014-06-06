% Images of Stereo Vision System
ILeft = imread('bag/left_images_color/left-image1330526257588048935.png');
IRight = imread('bag/right_images_color/right-image1330526257588048935.png');

% Loop Closing Candidate
ILoopClosing = imread('bag/left_images_color/left-image1330526265188024998.png');

[tvec, q, status, numInliers] = update(ILeft, IRight, ILoopClosing)

rvec = quat2dcm(q)

figure(1);
imshowpair(ILeft, ILoopClosing);


figure(2);
imshow(ILeft);

figure(3);
imshow(ILoopClosing);

figure(4);
drawAngle( acos(rvec(1,1)) );

r = quat2euler(q)

hold off;