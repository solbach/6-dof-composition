% Util program to read ROS visual odometry data
%   input:    filename
%   output:   Vector of Vector

function out2 = rosBagFileReader()
    
    out2     = dlmread( 'bag/viso.txt', ',' );
    
    size = [590, 88];
    
    out = load('bag/viso.txt', '-ascii');    
    
    fid = fopen('bag/viso.txt');
    % read, and transpose so samevals = myvals
    out = fread(fid, [590 88], 'double')';
    fclose(fid);
    
%     test2 = out(2,1) - out(3, 1)
%     test3 = out(3,1) - out(4, 1)
%     test4 = out(4,1) - out(5, 1)
%     test5 = out(5,1) - out(6, 1)
%     test6 = out(6,1) - out(7, 1)
%     test7 = out(7,1) - out(8, 1)
%     test8 = out(8,1) - out(9, 1)
        
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