function [Xplus, Jac1, Jac2] = comp2D(X1, X2)

    Xplus = [...
             [ X1(1) + X2(1) * cos( X1(3) ) - X2(2) * sin( X1(3) ) ]
             [ X1(2) + X2(1) * sin( X1(3) ) + X2(2) * cos( X1(3) ) ]
             [ X1(3) + X2(3) ]];
      
    if nargout > 1
    
        Jac1 = [...
                [ 1, 0, - X2(2)*cos( X1(3) ) - X2(1)*sin( X1(3) )]
                [ 0, 1,   X2(1)*cos( X1(3) ) - X2(2)*sin( X1(3) )]
                [ 0, 0,                                         1]];
        
        Jac2 = [...
                [ cos( X1(3) ), -sin( X1(3) ),  0]
                [ sin( X1(3) ),  cos( X1(3) ),  0]
                [            0,             0,  1]];
    
    end
   
             
end

%%
function f()
%%
    syms x y a x2 y2 a2 real
    x1 = [x, y, a];
    x2 = [x2, y2, a2];
    p_r = comp2D(x1, x2);
    Jac1 = jacobian(p_r, x1)
    Jac2 = jacobian(p_r, x2)
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