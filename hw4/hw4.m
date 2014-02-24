clear all;
clc;
close all;
addpath ../commonFunctions

I = getIMG('edgePhoto.jpg');
I = imresize(I,[400,400]);
I = rgb2gray(I);
I = im2double(I);
imshow(I);

%---------------------------------------------%
% problem 1                                   %
%---------------------------------------------%

%--------%
% part 1 %
%--------%
% Apply the horizontal sobel mask to the image. show the result.

sobelX=double([-1 0 1; -2 0 2; -1 0 1])


figure('name', 'sobel masks using custom convultion')
subplot(1,2,1)
horiz = convolution(I, sobelX);
imshow(im2uint8(horiz));
title('sobelX')


%--------%
% part 2 %
%--------%
% Apply the vertical sobel mask to the image. show the result.

sobelY=double([1 2 1; 0 0 0; -1 -2 -1])
subplot(1,2,2)
vert = convolution(I, sobelY);
imshow(im2uint8(vert));
title('sobelY')


%--------%
% part 3 %
%--------%
% use the magnitude to combine edges and show result

%pop pop
figure('name','magnitude');
magnitude = abs(horiz) + abs(vert);
imshow(magnitude);
title('approximation of magnitude');

%--------%
% part 4 %
%--------%
% Use different constant for c in sobel mask. try different values and see what happens
figure('name', 'various values for c in sobel mask')
subplot(2,2,1)
c=1;
sobelX=double([-1 0 1; -c 0 c; -1 0 1]);
sobelY=double([1 c 1; 0 0 0; -1 -c -1]);

h=convolution(I,sobelX);
v=convolution(I,sobelY);
c1=(abs(h)+abs(v));
imshow(c1);
title('c=1')

subplot(2,2,2);
c=3;
sobelX=double([-1 0 1; -c 0 c; -1 0 1]);
sobelY=double([1 c 1; 0 0 0; -1 -c -1]);
h=convolution(I,sobelX);
v=convolution(I,sobelY);
c1=(abs(h)+abs(v));
imshow(c1);
title('c=3')

subplot(2,2,3)
c=5;
sobelX=double([-1 0 1; -c 0 c; -1 0 1]);
sobelY=double([1 c 1; 0 0 0; -1 -c -1]);
h=convolution(I,sobelX);
v=convolution(I,sobelY);
c1=(abs(h)+abs(v));
imshow(c1);
title('c=5')


subplot(2,2,4)
c=10;
sobelX=double([-1 0 1; -c 0 c; -1 0 1]);
sobelY=double([1 c 1; 0 0 0; -1 -c -1]);
sobelSTART=tic
h=convolution(I,sobelX);
v=convolution(I,sobelY);
c1=(abs(h)+abs(v));
sobeltime= toc(sobelSTART)
imshow(c1);
title('c=10')


%--------%
% part 5 %
%--------%
% Use the Laplacian mask to edge detect same image, compare results

figure('name', 'laplacian mask')
L=[0 1 0; 1 -4 1; 0 1 0];
laplaceSTART = tic
laplacedI=convolution(I,L);
laplacetime = toc(laplaceSTART)
imshow(im2uint8(laplacedI)), title('laplacian mask');


%--------%
% part 6 %
%--------%
% compare computation times
sprintf('sobel approach: %s',sobeltime)
sprintf('laplacian approach: %s', laplacetime)


rmpath ../commonFunctions
%---------------------------------------------%
% problem 2                                   %
%---------------------------------------------%
addpath ../commonFunctions
%--------%
% part 1 %
%--------%
I2 = getIMG('Soyuz_TMA-19_spacecraft_departs_the_ISS.jpg');
I2 = im2double(rgb2gray(imresize(I2,[400,400])));

figure
c=2;
sobelX=double([-1 0 1; -c 0 c; -1 0 1]);
sobelY=double([1 c 1; 0 0 0; -1 -c -1]);
[M,N]=size(sobelX);
[M1,N1]=size(I2);
sobelX1 = padarray(sobelX,[(ceil(M1/2)-ceil(M/2)),(ceil(N1/2)-(ceil(N)/2))]);
imshow(sobelX1);
rmpath ../commonFunctions