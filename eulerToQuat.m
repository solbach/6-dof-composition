% Util program to convert euler angles to quaternions
% quaternion (q) will be formatted as follows:
% q = [w, x, y, z]

function q = eulerToQuat(roll, pitch, yaw)

    cR = cos( roll/2 );
    sR = sin( roll/2 );
    
    cP = cos( pitch/2 );
    sP = sin( pitch/2 );
    
    cY = cos( yaw/2 );
    sY = sin( yaw/2 );

    q(1) = cR.*cP.*sY - sR.*sP.*cY;
    q(2) = sR.*cP.*cY - cR.*sP.*sY;
    q(3) = cR.*sP.*cY + sR.*cP.*sY;
    q(4) = cR.*cP.*cY + sR.*sP.*sY;
    
end

%%
function f()
%%
    syms w x y z
    q = [w, x, y, z];
    p_r = quatToMatrix(q)
    
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