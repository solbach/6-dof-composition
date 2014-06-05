I1 = imread('bag/left_images_color/left-image1330526257588048935.png');
I2 = imread('bag/right_images_color/right-image1330526257588048935.png');
I3 = imrotate(I1, 30);

I3 = imread('bag/left_images_color/left-image1330526267988014936.png');

[tvec, q, status, numInliers] = update(I1, I2, I3)

quat2dcm(q)

figure(1);
imshowpair(I1, I3);

figure(2);
imshow(I1);
figure(3);
imshow(I3);