function [Xminus cov] = inversion(X, C)
%   This function calculates the 3D inversion using quaternions.
%   Note:   p is the translation vector (easy as it gets)
%           n, o and a are the column vector of the 3D Rotation Matrix.
%           Have a look on the pdf in the "doc" subfolder for more details.

% building translation matrix
    p = [ X(1); X(2); X(3); 1];

% get quaternions from data
    q = [ X(4), X(5), X(6), X(7) ];
      
% building rotation matrix
    R  = quatToMatrix(q);

% inverting
    qinv = quatInvers(q);
     
    n = R(:,1);
    
    o = R(:,2);
      
    a = R(:,3);
      
    Xminus = [ dot(-n, p);
               dot(-o, p);
               dot(-a, p);
               -qinv' ];
               
     if nargout > 1
        Jac = [...
               [ 2*X(6)^2 + 2*X(7)^2 - 1, - 2*X(4)*X(7) - 2*X(5)*X(6), ...
                    2*X(4)*X(6) - 2*X(5)*X(7), 2*X(3)*X(6) - 2*X(2)*X(7), ...
                    - 2*X(2)*X(6) - 2*X(3)*X(7), ...
                    4*X(1)*X(6) - 2*X(2)*X(5) + 2*X(3)*X(4), ...
                    4*X(1)*X(7) - 2*X(2)*X(4) - 2*X(3)*X(5)]
               [ 2*X(4)*X(7) - 2*X(5)*X(6), 2*X(5)^2 + 2*X(7)^2 - 1, ...
                    - 2*X(4)*X(5) - 2*X(6)*X(7), ...
                    2*X(1)*X(7) - 2*X(3)*X(5), ...
                    4*X(2)*X(5) - 2*X(1)*X(6) - 2*X(3)*X(4), ...
                    - 2*X(1)*X(5) - 2*X(3)*X(7), ...
                    2*X(1)*X(4) + 4*X(2)*X(7) - 2*X(3)*X(6)]
               [ - 2*X(4)*X(6) - 2*X(5)*X(7),   2*X(4)*X(5) - 2*X(6)*X(7), ...
                    2*X(5)^2 + 2*X(6)^2 - 1, 2*X(2)*X(5) - 2*X(1)*X(6), ...
                    2*X(2)*X(4) - 2*X(1)*X(7) + 4*X(3)*X(5), ...
                    4*X(3)*X(6) - 2*X(2)*X(7) - 2*X(1)*X(4), ...
                    - 2*X(1)*X(5) - 2*X(2)*X(6)]
               [ 0, 0, 0, -1, 0, 0, 0]
               [ 0, 0, 0, 0, 1, 0, 0]
               [ 0, 0, 0, 0, 0, 1, 0]
               [ 0, 0, 0, 0, 0, 0, 1]];
           
         cov = Jac * C * transpose( Jac );
  
     end

end

%%
function f()
%%
    syms x1 y1 z1 q1 q2 q3 q4;
    x1 = [ x1, y1, z1, q1, q2, q3, q4 ];
    cov = zeros( 7,7 );
    [p_r cov] = inversion(x1, cov)
    Jac = jacobian(p_r, x1)
end

% Copyright (c) 2014, Markus Solbach
% All rights reserved.

% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:

%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in
%       the documentation and/or other materials provided with the distribution

% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.