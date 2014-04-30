function [Xminus Jac1] = invers(X)
%   This function calculates the 3D inversion.
%   Note:   p is the translation vector (easX(2) as it gets)
%           n, o and a are the column vector of the 3D Rotation MatriX(1).
%           Have a look on the pdf in the "doc" subfolder for more details.

    p = [ X(1); X(2); X(3); 1];

    n = [ cos(X(5))*cos(X(6)); ... 
          sin(X(4))*sin(X(5))*cos(X(6))+cos(X(4))*sin(X(6)); ...
          -cos(X(4))*sin(X(5))*cos(X(6))+sin(X(4))*sin(X(6)); ...
          0];
    
    o = [ -cos(X(5))*sin(X(6)); ... 
          -sin(X(4))*sin(X(5))*sin(X(6))+cos(X(4))*cos(X(6)); ...
          cos(X(4))*sin(X(5))*cos(X(6))+sin(X(4))*cos(X(6)); ...
          0];
      
    a = [ sin(X(5)); ... 
          -sin(X(4))*cos(X(5)); ...
          cos(X(4))*cos(X(5)); ...
          0];

    A = [n o a p];
      
    Xminus = [ dot(-n, p);
               dot(-o, p);
               dot(-a, p);
               -X(4);
               -X(5);
               -X(6) ];
    
     if nargout > 1
         
         Jac1 = [...
             [ -cos(conj(X(6)))*cos(conj(X(5))), - cos(conj(X(4)))*sin(conj(X(6))) - cos(conj(X(6)))*sin(conj(X(4)))*sin(conj(X(5))),   cos(conj(X(4)))*cos(conj(X(6)))*sin(conj(X(5))) - sin(conj(X(4)))*sin(conj(X(6))), X(2)*(sin(conj(X(4)))*sin(conj(X(6))) - cos(conj(X(4)))*cos(conj(X(6)))*sin(conj(X(5)))) - X(3)*(cos(conj(X(4)))*sin(conj(X(6))) + cos(conj(X(6)))*sin(conj(X(4)))*sin(conj(X(5)))), X(1)*cos(conj(X(6)))*sin(conj(X(5))) + X(3)*cos(conj(X(4)))*cos(conj(X(6)))*cos(conj(X(5))) - X(2)*cos(conj(X(6)))*cos(conj(X(5)))*sin(conj(X(4))), X(1)*cos(conj(X(5)))*sin(conj(X(6))) - X(3)*(cos(conj(X(6)))*sin(conj(X(4))) + cos(conj(X(4)))*sin(conj(X(6)))*sin(conj(X(5)))) - X(2)*(cos(conj(X(4)))*cos(conj(X(6))) - sin(conj(X(4)))*sin(conj(X(6)))*sin(conj(X(5))))]
[  cos(conj(X(5)))*sin(conj(X(6))),   sin(conj(X(4)))*sin(conj(X(6)))*sin(conj(X(5))) - cos(conj(X(4)))*cos(conj(X(6))), - cos(conj(X(6)))*sin(conj(X(4))) - cos(conj(X(4)))*cos(conj(X(6)))*sin(conj(X(5))), X(2)*(cos(conj(X(6)))*sin(conj(X(4))) + cos(conj(X(4)))*sin(conj(X(6)))*sin(conj(X(5)))) - X(3)*(cos(conj(X(4)))*cos(conj(X(6))) - cos(conj(X(6)))*sin(conj(X(4)))*sin(conj(X(5)))), X(2)*cos(conj(X(5)))*sin(conj(X(4)))*sin(conj(X(6))) - X(3)*cos(conj(X(4)))*cos(conj(X(6)))*cos(conj(X(5))) - X(1)*sin(conj(X(6)))*sin(conj(X(5))), X(2)*(cos(conj(X(4)))*sin(conj(X(6))) + cos(conj(X(6)))*sin(conj(X(4)))*sin(conj(X(5)))) + X(3)*(sin(conj(X(4)))*sin(conj(X(6))) + cos(conj(X(4)))*sin(conj(X(6)))*sin(conj(X(5)))) + X(1)*cos(conj(X(6)))*cos(conj(X(5)))]
[                -sin(conj(X(5))),                                                  cos(conj(X(5)))*sin(conj(X(4))),                                                 -cos(conj(X(4)))*cos(conj(X(5))),                                                                                                   X(2)*cos(conj(X(4)))*cos(conj(X(5))) + X(3)*cos(conj(X(5)))*sin(conj(X(4))),                                              X(3)*cos(conj(X(4)))*sin(conj(X(5))) - X(1)*cos(conj(X(5))) - X(2)*sin(conj(X(4)))*sin(conj(X(5))),                                                                                                                                                                                                           0]
[                                0,                                                                                0,                                                                                0,                                                                                                                                                                      -1,                                                                                                                                       0,                                                                                                                                                                                                           0]
[                                0,                                                                                0,                                                                                0,                                                                                                                                                                       0,                                                                                                                                      -1,                                                                                                                                                                                                           0]
[                                0,                                                                                0,                                                                                0,                                                                                                                                                                       0,                                                                                                                                       0,                                                                                                                                                                                                          -1]
             ];
     end

end

%%
function f()
%%
    syms x y z phi theta psi
    x1 = [x, y, z, phi, theta, psi];
    p_r = invers(x1)
    Jac1 = jacobian(p_r, x1)
end

% CopX(2)right (c) 2014, Markus Solbach
% All rights reserved.

% Redistribution and use in source and binarX(2) forms, with or without
% modification, are permitted provided that the following conditions are
% met:

%     * Redistributions of source code must retain the above copX(2)right
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binarX(2) form must reproduce the above copX(2)right
%       notice, this list of conditions and the following disclaimer in
%       the documentation and/or other materials provided with the distribution

% THIS SOFTWARE IS PROVIDED BX(2) THE COPX(2)RIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANX(2) EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITX(2) AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPX(2)RIGHT OWNER OR CONTRIBUTORS BE
% LIABLE FOR ANX(2) DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARX(2), OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANX(2) THEORX(2) OF LIABILITX(2), WHETHER IN
% CONTRACT, STRICT LIABILITX(2), OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANX(2) WAX(2) OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITX(2) OF SUCH DAMAGE.