function drawAngle(theta)
% Taken from:
% http://stackoverflow.com/questions/1803043/how-do-i-display-an-arrow-positioned-at-a-specific-angle-in-matlab
    

    x = 1;                          %# X coordinate of arrow start
    y = 2;                          %# Y coordinate of arrow start
    
    L = 2;                          %# Length of arrow
    
    xEnd = x+L*cos(theta);          %# X coordinate of arrow end
    yEnd = y+L*sin(theta);          %# Y coordinate of arrow end
    
    points = linspace(0,theta);     %# 100 points from 0 to theta
    
    xCurve = x+(L/2).*cos(points);  %# X coordinates of curve
    yCurve = y+(L/2).*sin(points);  %# Y coordinates of curve
   
    plot(x+[-L L],[y y],'--k');     %# Plot dashed line
    hold on;                        %# Add subsequent plots to the current axes
    
    axis([x+[-L L] y+[-L L]]);      %# Set axis limits
    axis equal;                     %# Make tick increments of each axis equal
    
    arrow([x y],[xEnd yEnd]);       %# Plot arrow
    
    plot(xCurve,yCurve,'-k');       %# Plot curve
    plot(x,y,'o','MarkerEdgeColor','k','MarkerFaceColor','w');  %# Plot point
    lege = num2str(theta);
    
    legend(lege);
    
end