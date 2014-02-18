close all;
clear;
clf;
clc;

user=getenv('username')

if (ispc == 0)
	%filepath = strcat('/home/',user,'/Dropbox/')
	filepath = '/home/me/Dropbox/'
	image = strcat(filepath, 'Space_Shuttle_Columbia_launching.jpg')
else
	filepath='D:\home\Pictures\178\'
    image = strcat(filepath, 'Space_Shuttle_Columbia_launching.jpg')
end

I = imread(image);
I=rgb2gray(I);
figure('name' )

noisy = imnoise(I, 'gaussian');
mask = fspecial('gaussian', [5 5], 0.5)

test = conv2(noisy,mask);
imshow(test);
