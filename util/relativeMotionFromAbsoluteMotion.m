function [R] = relativeMotionFromAbsoluteMotion(A1, A2)
%   This function calculates the 3D relative motion between states
%   from two given 3D absolute state vectors.
%   Note:   R = opMINUS(A1) opPLUS(A2)
%           Provide the absolute state as follows:
%               - [ x, y, z, roll, pitch, yaw ]
%           Have a look on the pdf in the "doc" subfolder for more details.

    R = comp(invers(A1), A2);
   
end

%%
function f()
%%
%%
    syms x_x y_x z_x phi_x theta_x psi_x x_y y_y z_y phi_y theta_y psi_y real
    x1 = [x_x, y_x, z_x, phi_x, theta_x, psi_x];
    x2 = [x_y, y_y, z_y, phi_y, theta_y, psi_y];
    p_r = relativeMotionFromAbsoluteMotion(x1, x2)
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