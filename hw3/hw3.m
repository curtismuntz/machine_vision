close all;
clear;
clf;
clc;

user=getenv('username')

if (ispc == 0)
	filepath = strcat('/home/',user,'/Dropbox//')
	image = strcat(filepath, 'Space_Shuttle_Columbia_launching.jpg')
else
	filepath='D:\home\Pictures\178\'
end

I = imread(image);

noisy = imnoise(I, 'gaussian');
fspecial(5,'gaussian',0.5)