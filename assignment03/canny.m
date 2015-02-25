function output = canny(image, L, H, sigma)
% Performs canny edge detection on input image
% L is lower threshold (defines weak edges)
% H is the higher threshold (defines strong edges)
% sigma determines the size of the gaussian filters.

%Preallocate the output image.
output = zeros(size(image));

%Convert image to double for calculations. 
image = double(image);

% Compute the x/y gaussian
[filter_x, filter_y] = gradient(fspecial('gaussian',sigma));

% Compute gradient in x/y direction. 
s1 = imfilter(image,filter_x,'replicate');
s2 = imfilter(image,filter_y,'replicate');

%Magnitude 
magnitude = sqrt(s1.^2 + s2.^2);

%Perform non-maximum supression
magnitude = filter_non_max(magnitude,4); %4 neighborhood for now

%THRESHOLDS (L is low; H is high)
%Everything above the L (includes H)
low = magnitude;
low(low < L) = 0;
low(low >= L) = 1; 
%Everything above H
high = magnitude ;
high(high < H) = 0;
high(high >= H) = 1; 

%Find linear indexes of high image
high_idx = find(high);

%Find connected regions in low image
conn = bwconncomp(low,8); %8 neighborhood for now
%If the connected region has a pixel that's in the H image, it stays.
%(preserves weak edges that connect to strong edges)
for i=1:length(conn.PixelIdxList)
    if ~isempty(intersect(high_idx,conn.PixelIdxList{i}))
        output(conn.PixelIdxList{i}) = 1;
    end
end
end