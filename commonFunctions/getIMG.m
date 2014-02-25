function [I] = getIMG(imageNAMEwithextension)
% Find the file (different path on my linux vs Win installs)
% requires extension
if (ispc == 1)
	filepath='D:\home\Dropbox\Pictures\';
	image = strcat(filepath, imageNAMEwithextension);
elseif(ismac == 1)
	   filepath = '/Users/me/Dropbox/Pictures/';
	   image = strcat(filepath, imageNAMEwithextension);
else
	filepath = '~/me/Dropbox/Pictures/';
	image = strcat(filepath, imageNAMEwithextension);
end

I = imread(image);