
qhk = [-0.0732890013;	-0.0056918405;	-0.1743262351;	-0.9819402675];

% qGround = [1.55296500789410;-0.110841963028943;0.227406223579617;1.23442047977998];

qZK = [ 0.980533663058405; -0.105863528590796; -0.165269548670976; 0.00571184783263379 ];


% qYk = [0.999490131751699;-0.0262780322674373;-0.00765178716454715;0.0164435915879782];

[pitchH rollH yawH] = quat2angle(qhk', 'YXZ')
[pitchH rollH yawH] * 180/pi


% [pitchZ rollZ yawZ] = quat2angle(qGround', 'YXZ');
% [pitchZ rollZ yawZ] * 180/pi

[pitchZW rollZW yawZW] = quat2angle(qZK', 'YXZ');
[pitchZW rollZW yawZW] * 180/pi

% [pitchZW rollZW yawZW] = quat2angle(qYk', 'YXZ');
% [pitchZW rollZW yawZW] * 180/pi

% qnew = angle2quat( pitchZ, rollZ, yawZ, 'YXZ' )