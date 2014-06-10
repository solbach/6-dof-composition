% Images of Stereo Vision System
ILeft = imread('bag/left_images_color/left-image1330526257588048935.png');
IRight = imread('bag/right_images_color/right-image1330526257588048935.png');

% Loop Closing Candidate
ILoopClosing = imread('bag/left_images_color/left-image1330526265188024998.png');

pathLeft = 'bag/left_images_color';
fLeft = imageLoader(pathLeft);

pathRight = 'bag/right_images_color';
fRight = imageLoader(pathRight);

for c=1:length(fLeft)
    
    figure(1);
    ILeft=imread([pathLeft '/' fLeft{c}]);
    imshow(ILeft)
    
    figure(2);
    IRight=imread([pathRight '/' fRight{c}]);       
    imshow(IRight)
    
    pause(0.01)
end


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