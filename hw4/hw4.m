clear all;
clc;
close all;

addpath ../commonFunctions
I = getIMG('edgePhoto.jpg');
rmpath ../commonFunctions
I = imresize(I,[400,400]);
I = rgb2gray(I);
I = im2double(I);
imshow(I);

sobelX=double([-1 0 1; -2 0 2; -1 0 1])
sobelY=double([1 2 1; 0 0 0; -1 -2 -1])

addpath ../commonFunctions
figure('name', 'sobel masks')
subplot(1,2,1)
horiz = convolution(I, sobelX);
horiz = im2uint8(horiz);
imshow(horiz);
title('sobelX')

subplot(1,2,2)
vert = convolution(I, sobelY);
vert = im2uint8(vert);
imshow(vert);
title('sobelY')

rmpath ../commonFunctions

figure('name', 'sobel masks built in functions')
subplot(1,2,1)
horiz = conv2(I, sobelX);
imshow(horiz);
title('sobelX')

subplot(1,2,2)
vert = conv2(I, sobelY);
imshow(vert);
title('sobelY')