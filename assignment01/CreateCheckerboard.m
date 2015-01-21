function CreateCheckerboard(outpath)
%CreateCheckerboard 

%Create a 256x256 matrix of zeros (zero value = black)

%Using the checkerboard function.
% Note checkerboard makes half the board slightly darker. Use of >0.5 to
% remove.
img = (checkerboard(16,8) > 0.5); 

%The 3 lines below is how checkerboard() works minus making half the board darker.
%white = ones(16);
%black = zeros(16);
%img = mat2gray(repmat([black white; white black],8))

%Convert the matrix to a matlab image and save.
imwrite(img,outpath);

end

