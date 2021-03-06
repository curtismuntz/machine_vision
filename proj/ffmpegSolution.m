%% Project.m
% Most of the data is taken from this: % http://www.mathworks.com/help/matlab/examples/convert-between-image-sequences-and-video.html
clear all, close all, clc;


% Images and movies are too large and too many to store on this github page. They should be located on the desktop.
workingDir = 'C:\Users\me\Desktop\zzzGOODATA\';
fileNAME   = 'bounce.mp4';
cd(workingDir)
% mkdir(workingDir);
% mkdir(workingDir,'images');
% mkdir(workingDir,'left');
% mkdir(workingDir,'right');
vid = VideoReader(fileNAME);

%convert each frame into an imag
for ii = 1:vid.NumberOfFrames
    img = read(vid,ii);
    %resolution decided to maximize frames per second
	%crop each image to reclaim original frames
    Left  = img([1:480],[1:640],:);
	Right = img([1:480],[641:1280],:);
    imwrite(Left,fullfile(workingDir, 'bounce', sprintf('left%03d.jpg',ii)));
    imwrite(Right,fullfile(workingDir, 'bounce', sprintf('right%03d.jpg',ii)));
    imwrite(img,fullfile(workingDir, 'bounce', sprintf('img%03d.jpg',ii)));
end

%% Convert left frames into right frames (in the case that /dev/video0 is right
clear all, close all, clc;


% Images and movies are too large and too many to store on this github page. They should be located on the desktop.
workingDir = 'C:\Users\me\Desktop\zzzGOODATA\';
%fileNAME   = 'fiveFEET2.mp4';
fileNAME = 'lastTest.mp4';
cd(workingDir)
% mkdir(workingDir);
% mkdir(workingDir,'images');
% mkdir(workingDir,'left');
% mkdir(workingDir,'right');
vid = VideoReader(fileNAME);

%convert each frame into an imag
for ii = 1:vid.NumberOfFrames
    img = read(vid,ii);
    %resolution decided to maximize frames per second
	%crop each image to reclaim original frames
    Right  = img([1:480],[1:640],:);
	Left = img([1:480],[641:1280],:);
    imwrite(Left,fullfile(workingDir, 'lastTest', sprintf('left%04d.jpg',ii)));
    imwrite(Right,fullfile(workingDir, 'lastTest', sprintf('right%04d.jpg',ii)));
    imwrite(img,fullfile(workingDir, 'lastTest', sprintf('img%04d.jpg',ii)));
end


%% Convert left images into movie
%now these are stored as individual image directories
% cd('/Users/me/Desktop/stereo1/images/left/')
% imageNames = dir(fullfile(workingDir,'images','left','*.jpg'));
% imageNames = {imageNames.name}';
% 
% %match filenames containing digits
% imageStrings = regexp([imageNames{:}],'(\d*)','match');
% imageNumbers = str2double(imageStrings);
% 
% %sort frames from low to high
% [~,sortedIndices] = sort(imageNumbers);
% sortedImageNames = imageNames(sortedIndices);
% 
% %frames are now sorted
% %make an output file:
% outputVideo = VideoWriter(fullfile(workingDir,'_leftoutput.avi'));
% outputVideo.FrameRate = vid.FrameRate;
% open(outputVideo);
% 
% %Loop through the image sequence, load each image, and then write it to the video.
% for ii = 1:length(sortedImageNames)
%     img = imread(fullfile(workingDir,'images','left',sortedImageNames{ii}));
%     writeVideo(outputVideo,img);
% end
% close(outputVideo);
% cd ..
% 
% 

% %% Convert right images into movie
% %now these are stored as individual image directories
% cd('/Users/me/Desktop/EEE178/DATA/images/right/')
% imageNames = dir(fullfile(workingDir,'images','right','*.jpg'));
% imageNames = {imageNames.name}';
% 
% %match filenames containing digits
% imageStrings = regexp([imageNames{:}],'(\d*)','match');
% imageNumbers = str2double(imageStrings);
% 
% %sort frames from low to high
% [~,sortedIndices] = sort(imageNumbers);
% sortedImageNames = imageNames(sortedIndices);
% 
% %frames are now sorted
% %make an output file:
% outputVideo = VideoWriter(fullfile(workingDir,'_rightoutput.avi'));
% outputVideo.FrameRate = vid.FrameRate;
% open(outputVideo);
% cd ..
% %Loop through the image sequence, load each image, and then write it to the video.
% for ii = 1:length(sortedImageNames)
%     img = imread(fullfile(workingDir,'images','right',sortedImageNames{ii}));
%     writeVideo(outputVideo,img);
% end
% close(outputVideo);
