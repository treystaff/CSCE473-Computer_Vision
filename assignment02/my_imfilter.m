function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% See 'help imfilter' or 'help conv2'. While terms like "filtering" and
% "convolution" might be used interchangeably, and they are indeed nearly
% the same thing, there is a difference:
% from 'help filter2'
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.

% Your function should work for color images. Simply filter each color
% channel independently.

% Your function should work for filters of any width and height
% combination, as long as the width and height are odd (e.g. 1, 7, 9). This
% restriction makes it unambigious which pixel in the filter is the center
% pixel.

% Boundary handling can be tricky. The filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% you look at 'help conv2' and 'help imfilter' you see that they have
% several options to deal with boundaries. You should simply recreate the
% default behavior of imfilter -- pad the input image with zeros, and
% return a filtered image which matches the input resolution. A better
% approach is to mirror the image content over the boundaries for padding.

% % Uncomment if you want to simply call imfilter so you can see the desired
% % behavior. When you write your actual solution, you can't use imfilter,
% % filter2, conv2, etc. Simply loop over all the pixels and do the actual
% % computation. It might be slow.
% output = imfilter(image, filter);


%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%

%%
% Filter dimensions must be odd
[fr,fc] = size(filter);
if mod(fr,2) == 0 || mod(fc,2) == 0
    error('Filter dimensions must be odd');
end
% Calculate filter size
fsize = fr*fc;

% Get the image dimensions (Rows, Columns, Dimensions) 
[R,C,D] = size(image);
%The output will have the same image dimensions. 
output = zeros(R,C,D);

% Pad the input image with zeros.
rOffset = floor(fr/2);
cOffset = floor(fc/2);
image = padarray(image,[rOffset,cOffset]);

%Each dimension processed separately. 
for d=1:D
   %Loop through rows and columns
   for r=1:R
       for c=1:C
           %Multiply the filter by the area in the image the window is over
           fcalc = filter .* double(image(r:r+fr-1,c:c+fc-1,d));
           
           % Obtain the sum of the filter calculation
           output(r,c,d) = sum(fcalc(:));
       end
   end
output = cast(output,'like',image);
end

