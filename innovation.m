function yk = innovation( zk, hk )
% this function calculates the innovation by calculating the difference
% between the measurement (loop closing) and the estimation (odometry)
% INPUT  : zk measurement (loop closing)
%          hk estimation  (odometry)
% OUTPUT : yk innovation --> difference between zk and hk ( yk = zk - hk )

    for i=1:( length(zk)/7 )

    % difference of translation (simple substraction)
        transMeas = zk( 7*i-6:7*i-4 ); 
        transEsti = hk( 7*i-6:7*i-4 );

        diffTrans = transMeas - transEsti;

    % difference of rotation ( represented as quaternions )
    % diffQuat(q1, q2) = q1 * -q2
        rotMeas = zk( 7*i-3:7*i );
        rotEsti = hk( 7*i-3:7*i );

        diffRot = quatMult( quatInvers( rotEsti' ), rotMeas' );

    % Put everything together
        yk(7*i-6:7*i-4) = diffTrans;
        yk(7*i-3:7*i)   = diffRot;
    end
    yk              = yk';    
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