% State
x = [0, 0, 0, 0, 0, 0];

% Measurement (Odometry)
y = [2, 0, 0, 0*pi/180, 0*pi/180, 90*pi/180];
dt = 1;
tt = 0:dt:0;

% Loop
for t = tt
    
    y = [0, 0, 0, 0*pi/180, 0*pi/180, 45*pi/180];
    x = comp(x,y)
    
    y = [1, 0, 0, 0*pi/180, 0*pi/180, 0*pi/180];
    x = comp(x,y)
    %angle = x(6)*(180/pi)
    pause(0.1);
    %plot3(x(1), x(2), x(3), '.');
end


