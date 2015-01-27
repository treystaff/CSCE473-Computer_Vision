function CreateCheckerboard(outpath)
%CreateCheckerboard
% Arguments: 
%    outpath (str): the absolute path to where the image will be saved.
% Author: Trey Stafford

%Create a white and black 16x16 matrix .
white = ones(16);
black = zeros(16);

%repmat replicates the pattern 8x8 times to get the 256x256 image
img = mat2gray(repmat([black white; white black],8))

%Convert the matrix to a matlab image and save.
imwrite(img,outpath);

end

