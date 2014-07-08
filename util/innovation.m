function yk = innovation(zk, hk)
% This function applies a pure innovation to the position (x,y,z) and a
% special innovation to the orientation part (qw, q1, q2, q3) as follows:
%   quaternions --> euler angles --> diff(pitch, roll, yaw) --> quaternion
% INPUT : zk loopclosings from imageregistrations
%         hk loopclosing from statevector
% OUTPUT: yk innovation calculated as stated above

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

     end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Copyright (c) 2014, Markus Solbach
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