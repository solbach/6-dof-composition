% State
x = [0, 0, 0, 0, 0, 0];

% Measurement
y = [0, 0, 0, 0*pi/180, 0, 0];

dt = 1;
tt = 0:dt:10;

% Loop
for t = tt
    
    x = comp(x,y)
        
    pause(0.1);
    %plot3(x(1), x(2), x(3), '.');
end


