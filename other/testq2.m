
% q = [ w x z y ]

q1 = [ 1 0 0 1 ];

q2 = [ 1 0 0 1 ];

qDiff = [ 1 2 3 4 ]


% qh = [ 0.9429738894 0.3233567979 -0.0721876722 0.0320868389 ];


diffRot  = quatMult( quatInvers( q1 ), q2 );
diffRot2 = quatmultiply( quatinv( q1 ), q2 );
 
[ pitch roll yaw ] = quat2angle( diffRot2, 'YZX' );

[ pitch roll yaw ] * (180/pi);



    qw       = qDiff(4);
    qDiff(4) = qDiff(3);
    qDiff(3) = qDiff(2);
    qDiff(2) = qDiff(1);
    qDiff(1) = qw;
    
    qDiff