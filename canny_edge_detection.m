clc;
% Read the image using the path of image
inputImage = imread('C:\Users\Ashutosh Kumar\Desktop\pp\BloodImages\bld1.jpeg');
% Display the orginal image
figure,imshow(inputImage)
title('Orignal Image')
% converting the RGB image to gray scale image
grayImage = rgb2gray(inputImage);
% Display the gray image
figure,imshow(grayImage)
title('Gray Scale Image')
% Setting threshold for edge detection using canny algorithm
[~, threshold] = edge(grayImage, 'canny');
% Setting the sensitivity for edge detection
fudgeFactor = 1.5;
% Edge detection using sensitivity factor and threshold value
cannyEdgeImage = edge(grayImage,'canny', threshold*fudgeFactor);
% Display the Edge detected image
figure,imshow(cannyEdgeImage)
title('Canny Edge Detected Image')