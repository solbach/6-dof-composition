function cv_test
import cv.*;

    fprintf('Just a test\n');

    % Set up camera
    camera = VideoCapture;
    pause(3.5);
    
    
    for i = 1:100
        im = camera.read;
        im = resize(im,0.5);
        imshow(im);
        pause(0.05);
    end

end
