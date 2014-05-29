function [inlierPtsLeft, inlierPtsRight, Rt, status, fT, matchedPoints1] = findCorrespondenciesIndexUpdate(f1, vpts1, f2, vpts2)
% This function finds the correspondencies between given features
% It also filters outliers and calculates the
% Rototranslation between this images. 
% INPUT : 2 Feature sets (from a stereo vision system)
% RETURN: feature sets of the left and right image in corresponding order
   
%     Retrieve the locations of matched points. The SURF feature vectors are already normalized.
    indexPairs = matchFeatures(f1, f2, 'Prenormalized', true);
    f1Red = f1(indexPairs(:, 1),:); 
    matchedPoints1 = vpts1(indexPairs(:, 1));
    matchedPoints2 = vpts2(indexPairs(:, 2));
      
%     Exclude the outliers, and compute the transformation matrix.
    [Rt, inlierPtsLeft, inlierPtsRight, status] = ...
    estimateGeometricTransform(matchedPoints1,matchedPoints2,'similarity');

%     Update Indexlist
    index = -1;
    for i = 1:matchedPoints1.Count
        InL = matchedPoints1(i).Location;
        for j = 1:inlierPtsLeft.Count
            MaP = inlierPtsLeft(j).Location;
            if InL == MaP
                if index(1) == -1
                    index(1) = i;
                else
                    index = [index i];
                end
                break;
            end
        end    
    end

    fT = f1Red(index, :);
    
%     Debug output:

%     figure; showMatchedFeatures(I1g,I2g,matchedPoints1,matchedPoints2);
%     legend('matched points 1','matched points 2');
    
%     figure; showMatchedFeatures(I1g,I2g,inlierPtsLeft, ...
%                                inlierPtsRight);
%     title('Matched inlier points');
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