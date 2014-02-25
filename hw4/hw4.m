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
%%
sobelX=double([-1 0 1; -2 0 2; -1 0 1])


figure('name', 'sobel masks using custom convultion')
subplot(121)
horiz = convolution(I, sobelX);
imshow(im2uint8(horiz));
title('sobelX')


%--------%
% part 2 %
%--------%
% Apply the vertical sobel mask to the image. show the result.
%%
sobelY=double([1 2 1; 0 0 0; -1 -2 -1])
subplot(122)
vert = convolution(I, sobelY);
imshow(im2uint8(vert));
title('sobelY')


%--------%
% part 3 %
%--------%
% use the magnitude to combine edges and show result
%%
figure('name','magnitude'); %pop pop
magnitude = abs(horiz) + abs(vert);
imshow(magnitude);
title('approximation of magnitude');

%--------%
% part 4 %
%--------%
% Use different constant for c in sobel mask. try different values and see what happens
%%
figure('name', 'various values for c in sobel mask')
subplot(221)
c=1;
sobelX=double([-1 0 1; -c 0 c; -1 0 1]);
sobelY=double([1 c 1; 0 0 0; -1 -c -1]);

h=convolution(I,sobelX);
v=convolution(I,sobelY);
C=(abs(h)+abs(v));
imshow(C);
title('c=1')

subplot(222);
c=3;
sobelX=double([-1 0 1; -c 0 c; -1 0 1]);
sobelY=double([1 c 1; 0 0 0; -1 -c -1]);
h=convolution(I,sobelX);
v=convolution(I,sobelY);
C=(abs(h)+abs(v));
imshow(C);
title('c=3')

subplot(223)
c=5;
sobelX=double([-1 0 1; -c 0 c; -1 0 1]);
sobelY=double([1 c 1; 0 0 0; -1 -c -1]);
h=convolution(I,sobelX);
v=convolution(I,sobelY);
C=(abs(h)+abs(v));
imshow(C);
title('c=5')


subplot(224)
c=10;
sobelX=double([-1 0 1; -c 0 c; -1 0 1]);
sobelY=double([1 c 1; 0 0 0; -1 -c -1]);
startS=tic
h=convolution(I,sobelX);
v=convolution(I,sobelY);
C=(abs(h)+abs(v));
sobeltime= toc(startS)
imshow(C);
title('c=10')


%--------%
% part 5 %
%--------%
% Use the Laplacian mask to edge detect same image, compare results
%%
figure('name', 'laplacian mask')
L=[0 1 0; 1 -4 1; 0 1 0];
startL = tic
laplacedI=convolution(I,L);
laplacetime = toc(startL)
imshow(im2uint8(laplacedI)), title('laplacian mask');
rmpath ../commonFunctions

%--------%
% part 6 %
%--------%
% compare computation times
%%
sprintf('sobel approach: %s',sobeltime)
sprintf('laplacian approach: %s', laplacetime)



%---------------------------------------------%
% problem 2                                   %
%---------------------------------------------%
%--------%
% part 1 %
%--------%
% Obtain the FFT of the horizontal and vertical Sobel masks.
% You need to perform zero padding.
%%
addpath ../commonFunctions
I2 = getIMG('Soyuz_TMA-19_spacecraft_departs_the_ISS.jpg');
rmpath ../commonFunctions
I2 = im2double(rgb2gray(imresize(I2,[400,400])));
imshow(I2);

figure('name','ffts of sobel masks');
c=2;
sobelX=double([-1 0 1; -c 0 c; -1 0 1]);
sobelY=double([1 c 1; 0 0 0; -1 -c -1]);
[M,N]=size(sobelX);
[M1,N1]=size(I2);
sobelX1 = fft(padarray(sobelX,[ceil((ceil(M1/2)-ceil(M/2))),ceil((ceil(N1/2)-(ceil(N)/2))])));
sobelY1 = fft(padarray(sobelY,[ceil((ceil(M1/2)-ceil(M/2))),ceil((ceil(N1/2)-(ceil(N)/2))])));
subplot(121), imshow(sobelX1), title('sobelX fft');
subplot(122), imshow(sobelY1), title('sobelY fft');

%--------%
% part 2 %
%--------%
% Perform filtering in the frequency domain using the horizontal Sobel mask
%%
figure('name', 'frequency filtering');
horizF=I2.*sobelX1;
subplot(121), imshow(horizF), title('horizontal sobel freq');

%--------%
% part 3 %
%--------%
% Perform filtering in the frequency domain using the vertical Sobel mask
%%
vertF=I2.*sobelX1;
subplot(122), imshow(vertF), title('vertical sobel freq');

%--------%
% part 4 %
%--------%
% Obtain the FFT of the Laplacian mask. You need to perform zero padding
%%
L1 = fft(padarray(L,));

%--------%
% part 5 %
%--------%
% Perform filtering in the frequency domain using Laplacian to detect the edges.
%%
lapF=I2.*L1;
figure('name','laplacian frequency filtering'), imshow(lapF);

%--------%
% part 6 %
%--------%
% Construct a 3 by 3 mask for the Laplacian of Gaussian (LoG) and then obtain 
% its FFT. You can use fspecial for this question
%%

%--------%
% part 7 %
%--------%
% Perform filtering in the frequency domain using LoG to detect the edges
%%

%--------%
% part 8 %
%--------%
% Show and discuss your results.
%%


%---------------------------------------------%
% problem 3                                   %
%---------------------------------------------%
%--------%
% part 1 %
%--------%
% The Harris detector was introduced in 1988 for corner detection.
% An illustration is shown in figure 2. Apply the Harris
% detector to an image of your choice. Pick an image with visible corners. 
% Mark all corners on the image in a similar way to figure 2
%%
addpath ../commonFunctions
