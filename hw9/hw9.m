% Pre processing
clear all, close all, clc;
addpath ../commonFunctions
I1=getIMG('mvHW9A.jpg'); % <- learning set
I1=im2bw(I1);
I2=getIMG('mvHW9B.jpg'); % <- testing image
I2=imcomplement(im2bw(I2)); % objects need to be white
rmpath ../commonFunctions
%setSTATS=regionprops(I1,'all');
%testSTATS=regionprops(I2,'all'); %<- note that the objects are black in I2


imshow(I1);
figure
imshow(I2);
%% woo
% grab data points
close all
x=84; %start of object x=84, x+=134
y=32; %start of object y=32, y+=110
figure('name','A objects');
for i=1:10
    subplot(2,5,i)
    objRange=[x,y,110,110];
    objA=imcrop(I1, objRange);
    stats=regionprops(objA,'all')
    centAx(i)  = stats.Centroid(1);
    centAy(i)  = stats.Centroid(2);
    areaA(i)   = stats.Area;
    eccA(i)    = stats.Eccentricity;
    filledA(i) = stats.FilledArea;
    imshow(objA)
    x=x+134;
end

avgCentroidA     = [mean(centAx),mean(centAy)]
avgAreaA         = mean(areaA)
avgEccentricityA = mean(eccA)
avgFilledAreaA   = mean(filledA)



% x=84;
% y=y+110;
% figure('name','B objects');
% for i=1:10
%     subplot(2,5,i)
%     objRange=[x,y,110,110];
%     objB=imcrop(I1, objRange);
%     %Astats(i)=regionprops(objA,'all');
%     imshow(objB)
%     x=x+134;
% end
% 
% x=84;
% y=y+110;
% figure('name','C objects');
% for i=1:10
%     subplot(2,5,i)
%     objRange=[x,y,110,110];
%     objC=imcrop(I1, objRange);
%     %Astats(i)=regionprops(objA,'all');
%     imshow(objC)
%     x=x+134;
% end


%% 
%figure('name','lets try this out')
B=strel('disk',100);

stats = regionprops(I2,'all');
figure
imshow(I2), title('A elements highlighted'); hold on;
for i=1:size(stats)
    %if ((stats(i).Area < (avgAreaA+10000)) && (stats(i).Area > (avgAreaA-10000)))
    if((stats(i).EulerNumber == -1))
        N= floor(stats(i).Centroid(1));
        M= floor(stats(i).Centroid(2));
        %reconstructed(M,N) = true;
        plot(N,M,'s','color','green')
    end
end
hold off;

%% NN solution
% see http://www.mathworks.com/matlabcentral/fileexchange/32949-a-perceptron-learns-to-perform-a-binary-nand-function/content/PerceptronImpl.m