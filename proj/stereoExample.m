clear all; close all; clc;
% numImagePairs = 10;
% imageFiles1 = cell(numImagePairs, 1);
% imageFiles2 = cell(numImagePairs, 1);

imageDir = '/Users/me/Desktop/EEE178/DATA/calibration/';
%for i = 1:numImagePairs
%     imageFiles1{i} = dir(fullfile(imageDir, sprintf('video0*', i)));
%     imageFiles2{i} = dir(fullfile(imageDir, sprintf('video1*', i)));
% end




imageFiles1 = dir(fullfile(imageDir,'video0*'));
imageFiles2 = dir(fullfile(imageDir,'video1*'));

% Try to detect the checkerboard
im = imread(fullfile(imageDir, imageFiles1(10).name));
imagePoints = detectCheckerboardPoints(im);

% Display the image with the incorrectly detected checkerboard
% figure; imshow(im, 'InitialMagnification', 50);
% hold on;
% plot(imagePoints(:, 1), imagePoints(:, 2), '*-g');
% title('Failed Checkerboard Detection');


%% woostuffs

% images1 = cast([], 'uint8');
% images2 = cast([], 'uint8');
cd(imageDir)
% for i = 1:numel(imageFiles1)
%     images1(i) = imread(imageFiles1(i).name);
%     images2(i) = imread(imageFiles2(i).name);
% end


[imagePoints, boardSize] = detectCheckerboardPoints(imageFiles1(10).name, imageFiles2(10).name);
% 
% % Display one masked image with the correctly detected checkerboard
% figure; imshow(images1(:,:,:,1), 'InitialMagnification', 50);
% hold on;
% plot(imagePoints(:, 1, 1, 1), imagePoints(:, 2, 1, 1), '*-g');
% title('Successful Checkerboard Detection');
% 


% Generate world coordinates of the checkerboard points.
squareSize = 50.8; % millimeters
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Compute the stereo camera parameters.
stereoParams = estimateCameraParameters(imagePoints, worldPoints);

% Evaluate calibration accuracy.
figure; showReprojectionErrors(stereoParams);


% Read in the stereo pair of images.
I1 = imread('sceneReconstructionLeft.jpg');
I2 = imread('sceneReconstructionRight.jpg');

% Rectify the images.
[J1, J2] = rectifyStereoImages(I1, I2, stereoParams);

% Display the images before rectification.
figure; imshow(cat(3, I1(:,:,1), I2(:,:,2:3)), 'InitialMagnification', 50);
title('Before Rectification');

% Display the images after rectification.
figure; imshow(cat(3, J1(:,:,1), J2(:,:,2:3)), 'InitialMagnification', 50);
title('After Rectification');


%% Disparity Mapperton
disparityMap = disparity(rgb2gray(J1), rgb2gray(J2));
figure; imshow(disparityMap, [0, 64], 'InitialMagnification', 50);
colormap('jet');
colorbar;
title('Disparity Map');



pointCloud = reconstructScene(disparityMap, stereoParams);

% Convert from millimeters to meters.
pointCloud = pointCloud / 1000;



% Reduce the number of colors in the image to 128.
[reducedColorImage, reducedColorMap] = rgb2ind(J1, 128);

% Plot the 3D points of each color.
hFig = figure; hold on;
set(hFig, 'Position', [1 1 840   630]);
hAxes = gca;

X = pointCloud(:, :, 1);
Y = pointCloud(:, :, 2);
Z = pointCloud(:, :, 3);

for i = 1:size(reducedColorMap, 1)
    % Find the pixels of the current color.
    x = X(reducedColorImage == i-1);
    y = Y(reducedColorImage == i-1);
    z = Z(reducedColorImage == i-1);

    if isempty(x)
        continue;
    end

    % Eliminate invalid values.
    idx = isfinite(x);
    x = x(idx);
    y = y(idx);
    z = z(idx);

    % Plot points between 3 and 7 meters away from the camera.
    maxZ = 7;
    minZ = 3;
    x = x(z > minZ & z < maxZ);
    y = y(z > minZ & z < maxZ);
    z = z(z > minZ & z < maxZ);

    plot3(hAxes, x, y, z, '.', 'MarkerEdgeColor', reducedColorMap(i, :));
    hold on;
end

% Set up the view.
grid on;
cameratoolbar show;
axis vis3d
axis equal;
set(hAxes,'YDir','reverse', 'ZDir', 'reverse');
camorbit(-20, 25, 'camera', [0 1 0]);
