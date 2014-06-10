% PARAM:
% loopSample -> only search every 20 Images if we can find a loop closing
loopSample = 20;

% Load all Images of the stereo vision system (left and right)
pathLeft    = 'bag/left_images_color';
pathRight   = 'bag/right_images_color';

fLeft       = imageLoader(pathLeft);
fRight      = imageLoader(pathRight);

% Load images to detect loop closing 
%  (Just to be generic: normally we would use the left images of the 
%   stereo vision system)
pathLoop    = 'bag/left_images_color';
fLoop       = imageLoader(pathLoop);

% Actually this should be done starting by the odometry
% and look after every Nth odometry for a fitting stereo image pair
% with loop closing
for i=1:length(fLeft)
        
%     Try to find Loop closing candidate with a certain sampling rate
    if mod(i,loopSample) == 0  

%     Load Stereo Images from Database
        ILeft  = imread([pathLeft '/' fLeft{i}]);  
        IRight = imread([pathRight '/' fRight{i}]);  
        
%    Pass already observed Images to update function
        fCurrentLoop = fLoop(1:i-10);

        [loopClosings timestamps] = update( ILeft, IRight, fCurrentLoop, pathLoop );
        if( length( loopClosings ) >= 1 )
%             If we have at least one loop closing
%             Don't forget to safe the timestamp of the reference Image
%             (left image) at the end of the timestamp vector
            tim = fLeft{ i };
            tim = tim( 11:end-4 ); 
            timestamps = [ timestamps; tim ];
        end
    end        
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