function [x,y] = get_interest_points(image,threshold,alpha)
% [x,y] = get_interest_points(image,threshold,alpha)
% 
% Returns interest points from the image based on Harris Corner Detector 
%
% Input: 
%   image: an image (i.e., read with imread())
%   threshold: a value to threshold the response function (higher value =
%       fewer interest points)
%   alpha: alpha used in calculating the response function (typically 
%       ranges from 0.04 to 0.06)
%
% Output:
%   x: x coordinate(s) of interest point(s).
%   y: y coordinate(s) of interest point(s).
% 
% Example:
%   img = imread('onion.png')
%   [x,y] = get_interest_points(img,10000,0.04);
%   imshow(img);
%   hold on;
%   plot(x,y,'r+');

%Convert image to double for calculations that follow. 
image = double(image);

%Get x/y gradient filters that have been convolved w/ Gaussian (optional)
[filter_x, filter_y] = gradient(fspecial('gauss',3));

%Create a guassian filter.
filter = fspecial('gauss',3);

%Filter the image in both the x and y directions (replicate reduces noise
%at edges)
Ix = imfilter(image,filter_x,'replicate');
Iy = imfilter(image,filter_y,'replicate');

% Ixy is G(IxIy)
Ixy = imfilter(Ix .* Iy,filter,'replicate');

%Ix2 and Iy2 are G(Ix^2) and G(Iy^2), respectively
Ix2 = imfilter(Ix.^2, filter,'replicate');
Iy2 = imfilter(Iy.^2, filter, 'replicate');

%Compute the corner response function (based on Interest Points lecture
%slide 54)
R = Ix2.*Iy2-(Ixy.^2)-(alpha*(Ix2 + Iy2).^2);

%Threshold the image. 
R(R < threshold) = 0;

%Supress locally non-max values in the thresholded response image
R = filter_non_max(R,8); %8 neighborhood

%Find row/col pairs of all pixels that are still above zero. 
[rows,cols] = find(R);
%For now, return resuls as x's and y's
x = cols;
y = rows;
end