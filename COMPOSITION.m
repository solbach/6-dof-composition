% Full 3D Frame Composition with six degress of freedom
%
% I.    System
% 
%   Xplus   = f ( x, y )
%
%   x       : state vector            
%   y       : measurement vector
%
%   Xplus   : Updated state vector 
%   Jac1    : Jacobian Matrix with respect to x
%   Jac2    : Jacobian Matrix with respect to y
%
% II.   Calculation
%   
%   Delivered with this Project as a PDF
%
% III.  Plot result
%   
%   Full 3D Plot including robot movement and robot orientation
%
%
% IV.   Usage
%
%   Starting point is compMain.m. Here you can define the initial
%   state vector and the measurement vector and how often the 
%   measurement vector is applied to the state vector is defined 
%   with tt (the amount of loop iterations). 
%   Off course you can alternate the measurement vector for each
%   composition call. If you edit the loop keep in mind that
%   with the given approach here the robot 
%       first:  translates
%       second: rotates
%   With other Words: if you want the robot to do it vice versa
%   you need to play around with the measurement vector y:
%       first:  rotation angles but no translation (0, 0, 0)
%       second: translation
%   As it is right now implented in the loop.
%   Off course this can be easily solved with calculating the angles
%   first before applying the matrix (comp.m)
%
%   Necessary files are:
%       1.  comp.m
%       2.  compMain.m
%       3.  plot_dir3.m
%
%   All other files exist for better understanding.


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