% State
x = [0, 0, 0, 0, 0, 0];

% Measurement (Odometry)
y = [2, 0, 0, 0*pi/180, 0*pi/180, 90*pi/180];
dt = 1;
tt = 0:dt:10;

vX = 0;
vY = 0;
vZ = 0;

% Loop
for t = tt
    
    % I.    Rotate
    y = [0, 0, 0, 0*pi/180, 10*pi/180, 4*pi/180];
    x = comp(x,y);
    
    % II.   Translate
    y = [1, 0, 0, 0*pi/180, 0*pi/180, 0*pi/180];
    x = comp(x,y);
    
    % III.  Save Data to plot them
    vX = [vX x(1)];
    vY = [vY x(2)];
    vZ = [vZ x(3)];
    
end

   % vX = linspace(0,2*pi, 10)';
   % vY = sin (vX);
   % vZ = cos (vX);
   % plot_dir3(vX, vY, vZ);
    
plot_dir3(vX', vY', vZ');


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