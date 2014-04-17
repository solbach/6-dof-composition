% State
x = [0, 0, 0, 0, 0, 0];

% Measurement (Odometry)
y = [2, 0, 0, 0*pi/180, 0*pi/180, 90*pi/180];
dt = 1;
tt = 0:dt:10;

vX = 0;
vY = 0;
vZ = 0;

% Loop
for t = tt
    
    % I.    Rotate
    y = [0, 0, 0, 0*pi/180, 10*pi/180, 4*pi/180];
    x = comp(x,y);
    
    % II.   Translate
    y = [1, 0, 0, 0*pi/180, 0*pi/180, 0*pi/180];
    x = comp(x,y);
    
    % III.  Save Data to plot them
    vX = [vX x(1)];
    vY = [vY x(2)];
    vZ = [vZ x(3)];
    
end

   % vX = linspace(0,2*pi, 10)';
   % vY = sin (vX);
   % vZ = cos (vX);
   % plot_dir3(vX, vY, vZ);
    
plot_dir3(vX', vY', vZ');