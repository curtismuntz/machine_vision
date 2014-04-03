%% pre processing
clear all; close all; clc;
%code for my custom functions can be found on 
%https://github.com/curtismuntz/machine_vision/tree/master/commonFunctions
addpath ../commonFunctions;
%Problem 1 Data:
I1=getIMG('letters.jpg');
%Problem 2 Data:
I2=getIMG('Tux2.png');
%Problem 3 Data:
I3=getIMG('test1AP1.JPG');
rmpath ../commonFunctions;

%% Problem 1: Detect, Isolate and Transform the e’s in an Image
%% Part 1: Detect and Isolate e's
% In order to detect and isolate these e's, we need to define a structuring element, or set of structuring elements that will catch all of the e's.
clearvars -except I1 I2 I3;
I = im2bw(I1);
STATS = regionprops(I)
E = strel('disk',2);

%% Part 2: Transform e's Into Pixels
% To transform the e's into single pixels, we can simply run a hit and miss operation using our e mask and the complement of the e mask. Once this is completed, running a simple sum of this binary image will count the number of e's in the image. This obviously assumes that each instance of "e" is replaced by a single pixel and not multiple.
Enot=strel('square',3);
Img=bwhitmiss(I,E,Enot);
figure('name','e are now pixels'), imshow(Img), title('e now pixels')

eCount=sum(Img);

%% Part 3: Transform e's into 3's
% I chose to transform the e's in the image into 3's, as 3's are sort of like a backwards capital E.
threeMask=[];
Img = imdilate(Img, threeMask);
figure('name','e are now pixels'), imshow(Img), title('e now pixels')

%% Part 4: Discussion
% As seen in the previous parts, the method of choice was to use structuring elements and binary morphological operations.





%% Problem 2: Hough Transform to Detect Lines in Image
% Pick an image with visible lines. Use command
% houghpeaks
% to identify the peaks and then mark them with a small rectangle or circle
clearvars -except I1 I2 I3;




%% Problem 3: 
%We want to find the the extraterrestrial beings (aliens) in figure 1-right. Apply morphological and template matching techniques to detect the extraterrestrial beings. Use structuring elements that characterize the aliens’ eyes
