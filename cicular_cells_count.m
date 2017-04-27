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
se90 = strel('line', 1, 90);
se0 = strel('line', 1, 0);
dilatedImage= imdilate(cannyEdgeImage, [se90 se0]);
figure,imshow(dilatedImage)
title('Dilated Image')
borderClearedImage= imclearborder(cannyEdgeImage);
figure,imshow(borderClearedImage)
title('Border Cleared Image')
% Filling the holes of above processed image
imageWithFilledHoles = imfill(borderClearedImage,'holes');
% figure,imshow(imageWithFilledHoles)
% title('Image with Filled Holes')
% Extrating the circle on the basis of area of a cell
% Take the mask for the smallest and largest circle
% present in the image(to be processed)
% Filter out the image in between the mask area
extractCircle = bwpropfilt(imageWithFilledHoles,'area',[380 750]);
figure,imshow(extractCircle)
title('Extracted Circular Cell')
% Using the concept connected component to count the 
% number of circular cells
connectedComponent = bwconncomp(extractCircle, 4);
% Total number of circular cells

circularCellCount = connectedComponent.NumObjects;
fprintf('%s %d\n','Total number of circular cells = ',circularCellCount);