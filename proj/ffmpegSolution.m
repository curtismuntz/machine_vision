%% Project.m
% Most of the data is taken from this: % http://www.mathworks.com/help/matlab/examples/convert-between-image-sequences-and-video.html
clear all, close all, clc;


% Images and movies are too large and too many to store on this github page. They should be located on the desktop.
workingDir = '/Users/me/Desktop/stereo/';
cd(workingDir)
% mkdir(workingDir);
% mkdir(workingDir,'images');
% mkdir(workingDir,'left');
% mkdir(workingDir,'right');
vid = VideoReader('output.mp4');

%convert each frame into an image
for ii = 1:vid.NumberOfFrames
    img = read(vid,ii);
    %resolution decided to maximize frames per second
	%crop each image to reclaim original frames
    Left  = img([1:480],[1:640],:);
	Right = img([1:480],[641:1280],:);
    imwrite(Left,fullfile(workingDir,'images','left',sprintf('left%d.jpg',ii)));
    imwrite(Right,fullfile(workingDir,'images','right',sprintf('right%d.jpg',ii)));
    imwrite(img,fullfile(workingDir,'images',sprintf('img%d.jpg',ii)));
end



%% Convert left images into movie
%now these are stored as individual image directories
cd('/Users/me/Desktop/stereo/images/left')
imageNames = dir(fullfile(workingDir,'images','left','*.jpg'));
imageNames = {imageNames.name}';

%match filenames containing digits
imageStrings = regexp([imageNames{:}],'(\d*)','match');
imageNumbers = str2double(imageStrings);

%sort frames from low to high
[~,sortedIndices] = sort(imageNumbers);
sortedImageNames = imageNames(sortedIndices);

%frames are now sorted
%make an output file:
outputVideo = VideoWriter(fullfile(workingDir,'leftoutput.avi'));
outputVideo.FrameRate = vid.FrameRate;
open(outputVideo);

%Loop through the image sequence, load each image, and then write it to the video.
for ii = 1:length(sortedImageNames)
    img = imread(fullfile(workingDir,'images','left',sortedImageNames{ii}));
    writeVideo(outputVideo,img);
end
close(outputVideo);
cd ..

%% Convert right images into movie
%now these are stored as individual image directories
cd('/Users/me/Desktop/stereo/images/right')
imageNames = dir(fullfile(workingDir,'images','right','*.jpg'));
imageNames = {imageNames.name}';

%match filenames containing digits
imageStrings = regexp([imageNames{:}],'(\d*)','match');
imageNumbers = str2double(imageStrings);

%sort frames from low to high
[~,sortedIndices] = sort(imageNumbers);
sortedImageNames = imageNames(sortedIndices);

%frames are now sorted
%make an output file:
outputVideo = VideoWriter(fullfile(workingDir,'rightoutput.avi'));
outputVideo.FrameRate = vid.FrameRate;
open(outputVideo);
cd ..
%Loop through the image sequence, load each image, and then write it to the video.
for ii = 1:length(sortedImageNames)
    img = imread(fullfile(workingDir,'images','right',sortedImageNames{ii}));
    writeVideo(outputVideo,img);
end
close(outputVideo);



