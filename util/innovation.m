function yk = innovation(zk, hk)

%       Smooth innovation (Due to probably wrong loop closings)

%       If the sum of the innovation of one Loop Closing 

%       [x,y,z,qw,qx,qy,qz] is exceeding 1 discard this field

yk = zk - hk;

for i=1:length(zk)/7

%          show rotation of zk and hk

         rotZK = zk(i*7-3:i*7);

         rotHK = hk(i*7-3:i*7);

         

         [pitchZ rollZ yawZ] = quat2angle(rotZK', 'YXZ');

         [pitchZ rollZ yawZ] * 180/pi;

         

         [pitchH rollH yawH] = quat2angle(rotHK', 'YXZ');

         [pitchH rollH yawH] * 180/pi;  

         

         pitchDiff = pitchZ - pitchH;

         rollDiff = rollZ - rollH;

         yawDiff = yawZ - yawH;

         

         qDiff = angle2quat( pitchDiff, rollDiff, yawDiff, 'YXZ' );

         

         yk(i*7-3:i*7) = qDiff;

         

         in = yk(i*7-6:i*7);

         s = sum( abs( in ) );

         if( s > 1 )

 %             yk(i*7-6:i*7) = 0;

             la = s

         end

     end

end