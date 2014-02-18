close all;
clear;
clc;

user=getenv('username');

if (ispc == 0)
<<<<<<< HEAD
	%filepath = strcat('/home/',user,'/Dropbox/')
	filepath = '/home/me/Dropbox/'
	image = strcat(filepath, 'Space_Shuttle_Columbia_launching.jpg')
=======
	filepath = strcat('/home/',user,'/Dropbox/');
	image = strcat(filepath, 'Space_Shuttle_Columbia_launching.jpg');
>>>>>>> 04c7cd2de03680f0a60486541d97085abb2b5260
else
	filepath='D:\home\Documents\git\machine_vision\hw3\';
    image = strcat(filepath, 'Space_Shuttle_Columbia_launching.jpg');
end

%---------------------------------------------%
% problem 1                                   %
%---------------------------------------------%

%--------%
% part 1 %
%--------%
% transform an image to gray level
I = imread(image);
<<<<<<< HEAD
I=rgb2gray(I);
figure('name' )
=======
I = rgb2gray(I);
figure('name', 'original image');
title('original image');
imshow(I);
>>>>>>> 04c7cd2de03680f0a60486541d97085abb2b5260

%--------%
% part 2 %
%--------%
% add gaussian noise
noisy = imnoise(I, 'gaussian');
figure('name', 'noizy image');
title('noizy image');
imshow(noisy);

%--------%
% part 3 %
%--------%
% create 5x5 gauss mask
mask = fspecial('gaussian', [5 5], 0.5)

<<<<<<< HEAD
test = conv2(noisy,mask);
imshow(test);
=======
%--------%
% part 4 %
%--------%
% filter in space domain
% this utilizes custom convolution function.

cd ../hw2/
space = convolution(noisy, mask);
cd ../hw3/
figure('name', 'convolved (filtered) image');
title('convolved (filtered) image');
imshow(space);

%--------%
% part 5 %
%--------%
% fourier transform the image

fftd = fft2(noisy);
figure('name', 'fouriered image');
title('fouriered image');
imshow(fftd);

%--------%
% part 6 %
%--------%
% filter in frequency domain
cd ../hw3/
Z = fspecial('gaussian', [600 712], 0.5);
Z = fft2(Z);
filtered = fftd.*Z;

figure('name', 'freq filtered image');
title('freq filtered image');
imageD = ifft2(filtered);
dmin = min(min(abs(imageD))); dmax = max(max(abs(imageD)));
imshow( ( ifftshift(imageD)), [dmin dmax]),



%---------------------------------------------%
% problem 2                                   %
%---------------------------------------------%

%--------%
% part 1 %
%--------%
% Apply the DCT on an image of your choice.
I = imread(image);
I = rgb2gray(I);
I = double(I);
imDCT=dct2(I);
figure('name', 'dct')
title('dct')
imshow(log(abs(imDCT)), []), colormap(jet), colorbar;
>>>>>>> 04c7cd2de03680f0a60486541d97085abb2b5260
