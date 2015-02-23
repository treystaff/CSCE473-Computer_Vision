function output = marr_hildreth(image, sigma)
%Convert image to double.
image = double(image);

% Determine the size of the filter
N = abs(sigma*3)*2 + 1;

%Create the filter
filter = fspecial('log', N, sigma);

%Convolve the image with the log 
output = imfilter(image,filter,'replicate');

%Threshold the image
output(output < 0) = 0;
output(output > 0) = 1;

%Find zero crossings
%Note: preliminary results seem to indicate 4 neighbor works best..cleaner
%edges/thinner edges
cross_filter = [0 1 0; 1 100 1; 0 1 0]; %4 neighbor
%cross_filter = [1 1 1; 1 100 1; 1 1 1]; %8 neighbor
output = imfilter(output,cross_filter,'replicate');
output(output < 100) = 0;
output = mod(output,100);
output(4 < output < 0) = 1; %4 neighbor
%output(8 < output < 0) = 1; %8 neighbor
output(output == 4) = 0; %4 neighbor
%output(output == 8) = 0; %8 neighbor

end