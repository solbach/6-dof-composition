function Xplus = comp(X1, X2)
    result = X1;
    result(1) = X1(1) + X2(1) * cos(X1(5)) * cos(X1(6)) - ...
                X2(2) * cos(X1(5)) * sin(X1(6)) + ...
                X2(3) * sin(X1(5));
    
    Xplus = result;

end