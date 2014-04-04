%% pre processing
clear all; close all; clc;
%code for my custom functions can be found on 
%https://github.com/curtismuntz/machine_vision/tree/master/commonFunctions
addpath ../commonFunctions;
%Problem 1 Data:
I1=getIMG('letters.jpg');
%Problem 2 Data:
I2=getIMG('edges.png');
%Problem 3 Data:
I3=getIMG('test1AP1.JPG');
rmpath ../commonFunctions;

%% Problem 1: Detect, Isolate and Transform the es in an Image
%% Part 1: Detect and Isolate e's
% In order to detect and isolate these e's, we need to define a structuring element, or set of structuring elements that will catch all of the e's. Instead of choosing the easy route and making a generic skeleton of the letter e, I elected to examine each object in the image and look at the region properties of said objects. Based on an Area threshold of $80>Area>110$, an Euler Number of $0$, and a Perimiter range of $65>Perimiter<70$, All of the e's are detected and highlighted in the following image. The original e was cropped from the image, and the coordinates were placed into matlab to simplify the manual processing.
clearvars -except I1 I2 I3; close all
thresh=graythresh(I1);
I = im2bw(I1,thresh); %convert to bw
I = imcomplement(I); %objects are white in matlab

%basic e
theE=I([28:46],[223:240],:);
figure, imshow(theE)

eSTATS=regionprops(theE,'all');

reconstructed = false(size(I));
stats = regionprops(I,'all');
figure
imshow(I), title('es are highlighted'); hold on;
for i=1:size(stats)
    if ((stats(i).Area < 110) && (stats(i).Area > 80) && (stats(i).EulerNumber == 0) && (stats(i).ConvexArea < 200) && (stats(i).ConvexArea > 150) && (stats(i).Perimeter > 65) && (stats(i).Perimeter < 70))
        N= floor(stats(i).Centroid(1));
        M= floor(stats(i).Centroid(2));
        reconstructed(M,N) = true;
        plot(N,M,'s','color','green')
    end
end
hold off;


%% Part 2: Transform e's Into Pixels
% To transform the e's into single pixels, we can simply run a hit and miss operation using our e mask and the complement of the e mask. But because I elected to use region properties for this example, it was relatively easy to just include a Centroid calculation and toggle the centroid of the detected e into a true pixel value. This code can be seen in the previous section's for loop. The total number of e's in the image was 84.
figure('name','e are now pixels'), imshow(reconstructed), title('e now pixels')
eCount = sum(sum(reconstructed))

%% Part 3: Transform e's into squares's
% I chose to transform the e's in the image into squares. By exploiting the funcitonality of dilation, I dilate the pixel image with a square, and add the resultant image to the original image.
remover=zeros(size(theE));
remover=imcomplement(remover);
Img = imdilate(reconstructed,remover);

square = strel('square',15);
adder = imdilate(reconstructed, square);
figure('name','adder');
Img2=floor(I+Img);
Im3=Img2+adder;


figure('name','e are now squares'), imshow(Im3), title('e now different')

%% Part 4: Discussion
% The method of choice is explained in the previous parts.





%% Problem 2: Hough Transform to Detect Lines in Image
clearvars -except I1 I2 I3; close all;

I=zeros(200,200); I(150,:)=1; I(151,:)=1; I(152,:)=1;
I(:,100)=1; I(:,101)=1; I(:,102)=1;
[H,T,R]=hough(I);
P  = houghpeaks(H,2);
subplot(211); imagesc(I); colormap(gray)
subplot(212); imshow(imadjust(mat2gray(H)),'XData',T,'YData',R,'InitialMagnification','fit')
title('Hough Transform');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on; colormap(hot);
plot(T(P(:,2)),R(P(:,1)),'s','color','green')

%%
% The peaks have been generously highlighted by green. I noticed that the houghpeaks table excludes the repeated point, $(\theta=90$, \rho=150)$ and $(\theta=-90$, \rho=-150)$.

%% Problem 3: 
% We want to find the the extraterrestrial beings (aliens) in the image. I used matlab's findcircles function to determine the where circles exist, and then decided based on those answers which circles resemble the alien's eyes.

clearvars -except I1 I2 I3; close all;
thresh=graythresh(I3);
I=im2bw(I3,thresh);

[centers, radii, metric] = imfindcircles(I3,[5 20]);
centersStrong1 = centers(1,:);
radiiStrong1 = radii(1);
metricStrong1 = metric(1);

centersStrong2 = centers(5,:);
radiiStrong2 = radii(5);
metricStrong2 = metric(5);

imshow(I3), hold on;
viscircles(centersStrong1, radiiStrong1,'EdgeColor','r'), hold off;
viscircles(centersStrong2, radiiStrong2,'EdgeColor','r'), hold off;

