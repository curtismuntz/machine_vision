function [I] = getIMG(imageNAMEwithextension)
% Find the file (different path on my linux vs Win installs)
% requires extension
if (ispc == 0)
	filepath = '/home/me/Dropbox/';
	image = strcat(filepath, imageNAMEwithextension);
else
	filepath='D:\home\Dropbox\';
	image = strcat(filepath, imageNAMEwithextension);
end

I = imread(image);