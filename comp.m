function Xplus = comp(X1, X2)
    
    % Calculate new x-Position 
    result(1) = X1(1) + X2(1) * cos(X1(5)) * cos(X1(6)) - ...
                X2(2) * cos(X1(5)) * sin(X1(6)) + ...
                X2(3) * sin(X1(5));
    
	% Calculate new y-Position 
    result(2) = X1(2) + X2(1) * ( sin(X1(4)) * sin(X1(5)) * cos(X1(6)) +...
                cos(X1(4)) * sin(X1(6)) ) + ...
                X2(2) * ( -sin(X1(4)) * sin(X1(5)) * sin(X1(6)) + ...
                cos(X1(4)) * cos(X1(6)) ) + ...
                X2(3) * -sin(X1(4)) * cos(X1(5));
    
	% Calculate new z-Position 
    result(3) = X1(3) + X2(1) * ( -cos(X1(4)) * sin(X1(5)) * cos(X1(6))+...
                sin(X1(4)) * sin(X1(6)) ) + ...
                X2(2) * ( cos(X1(4)) * sin(X1(5)) * sin(X1(6)) + ...
                sin(X1(4)) * cos(X1(6)) ) + ...
                X2(3) * cos(X1(4)) * cos(X1(5));
    
	% Calculate new roll-Position 
    result(4) = X1(4) + X2(4);
    
    % Calculate new pitch-Position 
    result(5) = X1(5) + X2(5);
    
    % Calculate new yaw-Position 
    result(6) = X1(6) + X2(6);
    
    Xplus = result;

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