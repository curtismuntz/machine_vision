%EEE178 HW1
clear all;
close all;
clc;
clf;
cd imgs
%file paths
eulerimg = '/home/me/Pictures/480px-Leonhard_Euler_2.jpg';
rocket1 = '/home/me/Pictures/2014-1150.jpg';
rocket2 = '/home/me/Pictures/2014-1211.jpg';

%--------%
% part 1 %
%--------%
%load euler image into a matrix
[I,map] = imread(eulerimg,'jpg');
imfinfo(eulerimg);

%--------%
% part 2 %
%--------%
%display image
imshow(I);
imwrite(I,'originalimg.png');
%--------%
% part 3 %
%--------%
%transform image to gray level
figure('name', 'Gray Image');
grayI = rgb2gray(I);
imshow(grayI);
imwrite(grayI,'grayimg.png');

%--------%
% part 4 %
%--------%
%display image histogram
figure('name', 'Histogram');
imhist(grayI);
print -dpng histogram_bad;

%--------%
% part 5 %
%--------%
%resize image to 200x200 pixels
figure('name', 'Resized to 200x200');
resized = imresize(grayI, [200,200]);
imshow(resized);
imwrite(resized, 'resized.png');

%--------%
% part 6 %
%--------%
%transform image to binary, use two different thresholds to compare
%using standard threshold
figure('name', 'Binary Image');
binary1 = im2bw(resized);
imshow(binary1);
imwrite(binary1, 'binary1.png');
%using non-standard threshold
figure('name', 'Binary with non-standard threshold value');
binary2 = im2bw(resized,0.1);
imshow(binary2);
imwrite(binary2, 'binary_nonstandard.png');

%--------%
% part 9 %
%--------%
% %diffing using the binary images from before:
%loading color rocket images into matrices
[J,map]=imread(rocket1, 'jpg');
[K,map]=imread(rocket2, 'jpg');
%resizing them so i can add/subtract them from each other
Jsized = imresize(J, [200,200]);
Ksized = imresize(K, [200,200]);
%grayscaling
Jgray=rgb2gray(Jsized);
Kgray = rgb2gray(Ksized);
%differencing
figure('name', 'Rocket1');
imshow(Jgray);
imwrite(Jgray, 'rocket1.png');
figure('name', 'Rocket2');
imshow(Kgray);
imwrite(Kgray, 'rocket2.png')

figure('name','Difference between rockets');
diff1=Jgray-Kgray;
imshow(diff1);
imwrite(diff1, 'difference.png');
%summing
figure('name', 'Sum of two rockets');
sum1=Jgray+Kgray;
imshow(sum1);
imwrite(sum1, 'sum.png');
cd ..