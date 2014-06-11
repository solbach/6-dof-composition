function [hk H status] = calculateHandhk( X, tMeasureOdo, timestampsLC )
% This function calculates the relative estimated motion from with respect
% to the observed landmarks.
% INPUT  : X state vector containing all current states 
%          tMeasureOdo vector with corresponding timestamps 
%          timestampsLC vector with the timestamps of the loop closings

    status = 0;
%     because in this case the covariance doesn't matter we just set it to
%     a zero matrix
    cov  = zeros( 7, 7 );

%     create H Matrix MxN, where M is the sice of loop closings times 7 and
%     N the number of states, because each entry in H will be 7x7:
%     this is the size of each Jacobians, because every state consist of 7
%     values
    H = zeros( (length(timestampsLC) - 1)*7, length(X) );
    
%     create hk filled with zeros for easier access afterwards
    hk = zeros( (length(timestampsLC)-1)*7,1);
%     load absolute motions from state vector
%     load reference state
    timeRef = timestampsLC( end );
    
    posRef = find( tMeasureOdo == timeRef );

    xRef = X( (posRef*7-6):(posRef*7) );
        
    for i=1:(length(timestampsLC) - 1)
        pos = find( tMeasureOdo == timestampsLC( i ) );
        
        if( pos ~= 0 )
            status = 1;
            x1  = X( (pos*7-6):(pos*7) );
        
%           calculate relative motion. 
            [ h cov Jac1 Jac2 ] = relativeMotionFromAbsoluteMotionUQ(x1, cov, ...
                                                             xRef, cov);
        
%           push the both Jacobians to H-Matrix
            H( i*7-6:i*7 , (posRef*7-6):(posRef*7)) = Jac1;
            H( i*7-6:i*7 , (pos*7-6):(pos*7)) = Jac2;
        
%           push relative motions to hk vector
            hk( i*7-6:i*7 ) = h
        end
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