function [f, vpts] = findFeature(I)
% This function finds SURF Feature in a given Image
% SURF Features. It also filters outliers and calculates the
% Rototranslation between this images. 
% INPUT : 1 Image
% RETURN: feature set of this Image

%     convert the image to grayscale
    Ig = rgb2gray(I);

%     find surf feature
    points = detectSURFFeatures(Ig);
    
%     extract features
    [f, vpts] = extractFeatures(Ig, points);   
        
 end