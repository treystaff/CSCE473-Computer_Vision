% CSCE 473/873: Computer Vision
% Assignment 1
% Author: Trey Stafford

impath = 'onion.png'; %Path to image
savepath = 'D:\Pictures\CV_imgs\'; %Path to where generated images will be saved.

%Opening an image
img = imread(impath);
figure('Name','original img');
imshow(img); % Opens image in figure window
imtool(img); % Opens image in image tool gui window

% Convert to gray scale
gimg = rgb2gray(img);
imtool(gimg); %Open gray scale imaeg in image tool window

%Examine histogram
%Appears to be a dark image visually
figure('Name','gimg hist')
imhist(gimg); %Open image histogram in figure window.

%Resize the image & examine histogram.
%Histograms have the same approximate shape/distribution but frequencies
%are changed.
halfgimg = imresize(gimg,0.5); %Half the image's original size
figure('Name','half');
imshow(halfgimg); %Display the half-sized image
figure('Name','half hist');
imhist(halfgimg); %Examine the histogram of the half-sized image

doublegimg = imresize(gimg,2); %create a new image twice the orignal's size
figure('Name','double'); %Create a new figure window
imshow(doublegimg); % Show the double size img
figure('Name','double hist');
imhist(doublegimg); %histogram of double-sized image.

%Save the generated images. 
imwrite(gimg, strcat(savepath,'grayscale.png'));
imwrite(halfgimg, strcat(savepath, 'half_size.png'));
imwrite(doublegimg, strcat(savepath, 'double_size.png'));
