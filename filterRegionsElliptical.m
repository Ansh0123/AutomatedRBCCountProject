function [BW_out,properties] = filterRegionsElliptical(BW_in)
BW_out = BW_in;
BW_out = imclearborder(BW_out);
BW_out = imfill(BW_out, 'holes');
BW_out = bwpropfilt(BW_out, 'MajorAxisLength', [30, 90]);
BW_out = bwpropfilt(BW_out, 'MinorAxisLength', [0, 30]);
BW_out = bwpropfilt(BW_out, 'Eccentricity', [0.795, 0.907]);
BW_out = bwpropfilt(BW_out, 'Area', [300, 2700]);
properties = regionprops(BW_out, {'Eccentricity','MajorAxisLength', 'MinorAxisLength','Perimeter'});

