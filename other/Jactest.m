function result = Jactest (X, Y)

    result = [ X(1) + Y(1) * cos(X(3)) - Y(2) * sin(X(3)); ...
               X(2) + Y(1) * sin(X(3)) + Y(2) * cos(X(3)); ...
               X(3) + Y(3) ];

end


function f()
%%
    syms x1 y1 theta x2 y2 theta2;
    x1 = [ x1, y1, theta ];
    x2 = [ x2, y2, theta2 ];
    p_r = Jactest(x1, x2)
    Jac1 = jacobian(p_r, x1)
    Jac2 = jacobian(p_r, x2)
end