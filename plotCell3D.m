function Q = plotCell3D(P3)
%    3D Plot if a cell 
    
    x = P3{1,1};
    y = P3{1,2};
    z = P3{1,3};

    for i = 2:size(P3)
       x = [x P3{i,1}];
       y = [y P3{1,2}];
       z = [z P3{1,3}];  
    end
    
    plot3(x,y,z, '+');
    
end
