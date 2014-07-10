function distance = euclidDistance( pos1, pos2 )
% This function calculates the euclidean distance between two given points
% INPUT  : pos1 first position
%          pos2 second position
% OUTPUT : distance euclidean distance between both points

% calculate difference in x, y and z direction
diffX = pos1(1) - pos2(1);
diffY = pos1(2) - pos2(2);
diffZ = pos1(3) - pos2(3);

% calculate euclidean distance d = sqrt(x²+y²+...+n²)

distance = sqrt(diffX*diffX + diffY*diffY + diffZ*diffZ);

end