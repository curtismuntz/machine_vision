%% Preprocessing
clear all; close all; clc;

set(0,'DefaultFigureWindowStyle','docked');

%Curtis' directory
base_dir = 'C:\Users\me\Desktop\zzzGOODATA\bounce';

%David's directory
% base_dir = 'C:\Users\David\Desktop\SHAREDPROJECT\zzzGOODATA\bounce';
cd(base_dir);


%% frame listings
listLeft =  dir('left*');
listRight= dir('right*');

%% color stuff
close all;
figure('name','colorspace');
i=430;
for i=460:2:500%length(listLeft)
    
    Im_raw=(imread(listLeft(i).name));
    Im=rgb2ycbcr(imread(listLeft(i).name));
    Im_cr=Im(:,:,3);
    
    
    subplot(231);
    imshow(Im_raw);
    title('raw image');
    
    subplot(232);
    imshow(Im);
    title('YCbCr');
    
    subplot(233)
    imshow(Im_cr);
    title('Chroma');

    
    
    S=strel('disk',9); %bounce
    subplot(234)
    Bw=im2bw(Im_cr,0.57);
    imshow(Bw);
    title('im2bw');

    
    
    subplot(235) 
    Bw=imerode(Bw,S);
    Bw=imdilate(Bw,S);

    imshow(Bw);
    title('Isolated object');
    
    stats=regionprops(Bw);
    index=[0 0];
    totArea=0;
    for j=1:length(stats)
        totArea=totArea+stats(j).Area;
    end
    
    for j=1:length(stats)
        index=index+stats(j).Centroid*(stats(j).Area/totArea);
    end

    subplot(236)
    imshow(Im_raw), title('Tracked Object'); hold on;
    plot(index(1), index(2), 's', 'color', 'cyan'); hold off;

    pause(0.01);
end
