function output = filter_non_max(image,neighborhood)
% [output] = filter_non_max(image, neighborhood)
% 
% Removes non-maximum responses within the defined neighborhood
%
% Input: 
%   image: an  image (i.e., read with imread())
%   neighborhood: int (4 or 8)
%
% Output:
%   output: image with non-maximum values reduced to zero.
%
% Example:
%   output = filter_non_max(rgb2gray(imread('onion.png')),8);

image = double(image);

if neighborhood == 4 
    max_area = [0 1 0; 1 1 1; 0 1 0];
elseif neighborhood == 8
    max_area = ones(3);
else
    error('neighborbood must be 4 or 8')
end

% Get the image dimensions (Rows, Columns, Bands)
[R,C,B] = size(image);
%The output will have the same image dimensions. 
output = image;

image = padarray(image,[1,1]);

%Each image band is processed separately. 
for d=1:B
   %Loop through rows and columns
   for r=1:R
       for c=1:C
           %Retain neighborbood values over the area in the image the window is over
           matches = max_area .* image(r:r+2,c:c+2,d);
           %
           if image(r+1,c+1,d) ~= max(max(matches));
               output(r,c,d) = 0;
           else
               output(r,c,d) = image(r+1,c+1,d);
           end
       end
   end
end
    
end