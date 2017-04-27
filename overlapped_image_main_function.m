clc;
inputImage = imread('C:\Users\Ashutosh Kumar\Desktop\pp\BloodImages\bld1.jpeg');
figure,imshow(inputImage)
grayImage = rgb2gray(inputImage);
% clearedBorderImage = imclearborder(grayImage);
[~, threshold] = edge(grayImage, 'canny');
fudgeFactor = 1.5;
edgeImage = edge(grayImage,'canny', threshold * fudgeFactor);
% Funciton call to extract the overlapped cell 
[extractOverlappedCells,properties]=filterRegionsElliptical(edgeImage);
figure,imshow(extractOverlappedCells)
connectedComponent = bwconncomp(extractOverlappedCells, 4);
% Total number of Overlapped cells
overlappedCellsCount = connectedComponent.NumObjects;
fprintf('%s %d\n','Total number of overlapped cells = ',overlappedCellsCount);