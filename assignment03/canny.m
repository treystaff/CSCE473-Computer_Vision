function output = canny(image, L, H, sigma)

output = zeros(size(image));

image = double(image);

% Compute the x/y gaussian
[filter_x, filter_y] = gradient(fspecial('gaussian',sigma));

% Compute gradient in x/y direction. 
s1 = imfilter(image,filter_x,'replicate');
s2 = imfilter(image,filter_y,'replicate');

%Magnitude 
magnitude = sqrt(s1.^2 + s2.^2);

%Perform non-maximum supression
magnitude = filter_non_max(magnitude,4);

%THRESHOLDS (L is low; H is high)
%Everything above the lower TH (includes high)
low = magnitude;
low(low < L) = 0;
low(low >= L) = 1; 
%Everything above higher TH
high = magnitude ;
high(high < H) = 0;
high(high >= H) = 1; 

%Find linear indexes of high image
high_idx = find(high);

%Find connected regions in low image
conn = bwconncomp(low,8); %8 neighborbood for now
for i=1:length(conn.PixelIdxList)
    if ~isempty(intersect(high_idx,conn.PixelIdxList{i}))
        output(conn.PixelIdxList{i}) = 1;
    end
end
end