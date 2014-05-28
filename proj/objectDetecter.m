%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% EEE 178 - Project
% Object Detection
% Curtis Muntz, Thao Chau, David Larribas
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%% Preprocessing
clear all; close all; clc;

%embeded figures, yo
set(0,'DefaultFigureWindowStyle','docked');

%where are the images located? right thurr\/
base_dir = 'C:\Users\me\Desktop\zzzGOODATA\bounce';
%base_dir='C:\Users\me\Desktop\zzzGOODATA\whitebackground\davidImgs';
cd(base_dir);

%% frame listings
listLeft =  dir('left*');
listRight= dir('right*');

%% background subtraction
numFrames=100;
tmp=rgb2gray(imread(listLeft(1).name));
[M,N]=size(tmp);
bgLeft = zeros(M,N);
bgRight = zeros(M,N);
for i=1:numFrames    %read images
    imgLeft=im2double(rgb2gray(imread(listLeft(i).name)));
    imgRight=im2double(rgb2gray(imread(listRight(i).name)));
    bgLeft = bgLeft + imgLeft;
    bgRight = bgRight + imgRight;
end
bgLeft = bgLeft/numFrames;
bgRight = bgRight/numFrames;

figure('name','Background of Images')
subplot(121)
imshow(bgLeft)
subplot(122)
imshow(bgRight)

%% object cleanup
% figure('name','histogram');
% Imlft=im2double(rgb2gray(imread(listLeft(628).name)));
% imhist(Imlft)
% 


% figure('name','omg')
% Imlft=im2double(rgb2gray(imread(listLeft(628).name)));
% Imlft=im2bw(abs(Imlft- bgLeft),thresh);
% imshow(Imlft);

hsize = 1;
sigma = 0.1;
gaus_filt = fspecial('gaussian',hsize , sigma);
thresh=0.2;
%% sh
thresh=0.2;
figure('name','thresholded data')
%for i=600:5:length(listLeft)
for i=460:1:length(listLeft)
    Im=im2double(rgb2gray(imread(listLeft(i).name)));

    Im_bg=abs(Im-bgLeft);
    subplot(224)
    imshow(Im_bg)
    gaus_img = filter2(gaus_filt,Im_bg,'same');     
    
    subplot(222);imshow(gaus_img); title('filtrd');
    Imbw=im2bw(gaus_img,thresh);
    
    
    subplot(223)
    imshow(Imbw), title('blacknwhite');
    
    %CLOSING
    stats=regionprops(Imbw);
    index=[0 0];
    totArea=0;
    for j=1:length(stats)
        totArea=totArea+stats(j).Area;
    end
    
    for j=1:length(stats)
        index=index+stats(j).Centroid*(stats(j).Area/totArea);
    end
    
    subplot(224)
    tmp = im2double(Imbw);
    imshow(tmp.*Im);

    subplot(221)
    imshow(Im), title('raw'); hold on;
    plot(index(1), index(2), 's', 'color', 'green'); hold off;
    pause(0.1);
end


%% Final Tracking Code
close all
figure('name','thresholded data')
threeDtracker=[0,0,0];
for i=460:5:length(listLeft)
%for i=415:1:430
    Image_left=im2double(rgb2gray(imread(listLeft(i).name)));
    Image_left_bg=abs(Image_left-bgLeft);
    
    Image_right=im2double(rgb2gray(imread(listRight(i).name)));
    Image_right_bg=abs(Image_right-bgRight);
    
    
    gauss_left_img =filter2(gaus_filt,Image_left_bg,'same');
    gauss_right_img =filter2(gaus_filt,Image_right_bg,'same');  
    
    
    %subplot(232);imshow(gaus_img); title('filtrd');
    Image_bw_left=im2bw(gauss_left_img,thresh);
    Image_bw_right=im2bw(gauss_right_img,thresh);
%     subplot(223)
%     imshow(Image_bw_left), title('blacknwhite');
    
    %track LEFT
    stats=regionprops(Image_bw_left);
    index_left=[0 0];
    totArea=0;
    for j=1:length(stats)
        totArea=totArea+stats(j).Area;
    end
    
    for j=1:length(stats)
        index_left=index_left+stats(j).Centroid*(stats(j).Area/totArea);
    end
    
    stats=regionprops(Image_bw_right);
    index_right=[0 0];
    totArea=0;
    for j=1:length(stats)
        totArea=totArea+stats(j).Area;
    end
    
    for j=1:length(stats)
        index_right=index_right+stats(j).Centroid*(stats(j).Area/totArea);
    end
    
    subplot(221)
    imshow(Image_left); title('Left Raw Image');
    subplot(222)
    imshow(Image_right); title('Right Raw Image');
    
    subplot(223)
    imshow(Image_left), title('Tracking Objects'); hold on;
    plot(index_left(1), index_left(2), 's', 'color', 'green'); hold on;
    plot(index_right(1), index_right(2), 's', 'color', 'red'); hold off;
    [p, v, a, prevP, prevV] = getPhysics(index_right(1), index_right(1),index_left(1),index_left(2),0,0);
    
    subplot(224)
    threeDtracker=[threeDtracker;p];
    %plot3(threeDtracker(:,1),threeDtracker(:,2),threeDtracker(:,3));
    % X plot
    plot(threeDtracker(2:end,1),'-','Color','r'); hold on;
    plot(threeDtracker(2:end,2),'-','Color','g'); hold on;
    plot(threeDtracker(2:end,3),'-','Color','c'); hold on;
    title('Plotting Data')
    xlabel('sample')
    ylabel('Position (m)')
    legend('X','Y','Z'), hold off;
    
    pause(0.1);
end


