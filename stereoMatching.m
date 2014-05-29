function P3 = stereoMatching(I1, I2)
%     find correspondencies between images and calculate 3D Points

%     I. Find Feature (SURF)
    [f1, vpts1] = findFeature(I1);
    [f2, vpts2] = findFeature(I2);
    
%     II. Find Correspondencies (with outlier elimination)

    [inlierPtsLeft, inlierPtsRight] = findCorrespondencies(f1, vpts1, f2, vpts2);

    P2L = zeros(inlierPtsLeft.Count, 2);
    P2R = zeros(inlierPtsRight.Count, 2);
    
    for i = 1:inlierPtsLeft.Count
        PLTemp = inlierPtsLeft(i).Location;
        P2L(i,1) = PLTemp(1);
        P2L(i,2) = PLTemp(2);
        
        
        PRTemp = inlierPtsRight(i).Location;
        P2R(i,1) = i;
        P2R(i,2) =inlierPtsLeft.Count - i;
    end
    
    figure; showMatchedFeatures(I1,I2,P2L, ...
                               P2R);
    title('Matched inlier points');
    
%     III. Calculate 3D Point for each Correspondency    
    P3 = zeros(inlierPtsLeft.Count, 3);
    
    for i = 1:inlierPtsLeft.Count
        pTemp = calculate3DPoint(inlierPtsLeft(i).Location, ...
                                   inlierPtsRight(i).Location);
        P3(i,1) = pTemp(1);
        P3(i,2) = pTemp(2);
        P3(i,3) = pTemp(3);
    end
    
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