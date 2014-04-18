clear all, close all; clc;

numImages = 4;
images1 = cell(1, numImages);
images2 = cell(1, numImages);
for i = 1:numImages
    images1{i} = fullfile('Users', 'me', 'Desktop', 'EEE178', 'DATA', 'calibration' ,sprintf('video0_calib_%01d.jpg', i));
    images2{i} = fullfile('Users', 'me', 'Desktop', 'EEE178', 'DATA', 'calibration' ,sprintf('video1_calib_%01d.jpg', i));
end

[imagePoints, boardSize, pairsUsed] = detectCheckerboardPoints(images1, images2);
