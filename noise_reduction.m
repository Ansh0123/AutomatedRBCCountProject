clc;
inputImage = imread('C:\Users\Ashutosh Kumar\Desktop\pp\BloodImages\bld1.jpeg');
figure,imshow(inputImage)
title('Orignal Image')
grayImage = rgb2gray(inputImage);
figure,imshow(grayImage)
title('Gray Scale Image')
[~, threshold] = edge(grayImage, 'canny');
fudgeFactor = 1.5;
cannyEdgeImage = edge(grayImage,'canny', threshold*fudgeFactor);
figure,imshow(cannyEdgeImage)
title('Canny Edge Detected Image')
% Setting the threshold at an angle 90 and 0 to dilate the edge
se90 = strel('line', 1, 90);
se60 = strel('line',1,60);
se0 = strel('line', 1, 0);
% Dilating the image at the threhold angle
dilatedImage= imdilate(cannyEdgeImage, [se90 se0 se60]);
% Display the dilated image
figure,imshow(dilatedImage)
title('Dilated Image')
% Clearing the umwanted part of image at broder
borderClearedImage= imclearborder(cannyEdgeImage);
% Display the border cleared image
figure,imshow(borderClearedImage)
title('Border Cleared Image')