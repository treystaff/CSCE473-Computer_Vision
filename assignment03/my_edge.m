function [magnitude, orientation] = my_edge(image, type, threshold)
% Supported types include sobel, prewitt, Laplacian

%Convert img to doubles
image = double(image);

% Create the desired filter.  
filter = fspecial(type);
if ~strcmpi(type,'laplacian')
    % Approximate x and y derivatives (gradients)
    s1 = imfilter(image,filter,'replicate');
    s2 = imfilter(image,filter','replicate'); %The filter is transposed. 

    %Compute magnitude and orientation images. 
    magnitude = sqrt(s1.^2 + s2.^2);
    orientation = atan(s2./s1);
    orientation(isnan(orientation)) = 0; %Replace NaNs w/ zeros (divide by zero=NaN)

    % Threshold the magnitude image. 
    thresh = magnitude <= threshold;
    magnitude(thresh) = 0; %All values less than the threshold get a value of 0

    %Threshold the orientation image with the new magnitude image.
    orientation(thresh) = 0;
else
   orientation = NaN;
   magnitude = imfilter(image,filter,'replicate');
   magnitude(magnitude <= threshold) = 0; %Is this all that has to be done?
   
end

end