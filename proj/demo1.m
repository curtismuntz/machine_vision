%% Preprocessing
clear all; close all; clc;

set(0,'DefaultFigureWindowStyle','docked');

%Curtis' directory
base_dir = 'C:\Users\me\Desktop\zzzGOODATA\bounce';

%David's directory
% base_dir = 'C:\Users\David\Desktop\SHAREDPROJECT\zzzGOODATA\bounce';
cd(base_dir);

%% frame listings
listLeft =  dir('right*');
listRight= dir('left*');

% %% color stuff
% close all;
% figure('name','colorspace');
% i=430;
% for i=460:5:length(listRight)
%     
%     %Im=rgb2hsv(imread(listLeft(i).name));
%     Im=rgb2ycbcr(imread(listRight(i).name));
% %     Im=imread(listLeft(i).name);
% %     colormap(rgb)
%     ImRed=Im(:,:,1);
%     ImGreen=Im(:,:,2);
%     ImBlue=Im(:,:,3);
%     
%     subplot(231)
%     imagesc(ImBlue);
% %     subplot(232)
% %     imagesc(ImGreen);
% %     subplot(233)
% %     imagesc(ImBlue);
% %     
%     S=strel('disk',9); %bounce
%     
%     subplot(232)
%     Bw=im2bw(ImBlue,0.57);
%     %Bw=imopen(Bw,S);
%     %Bw=imclose(Bw,S);
%     
%     Bw=imerode(Bw,S);
%     Bw=imdilate(Bw,S);
%     
%     
%     subplot(233)
%     imshow(Bw);
%     
%     stats=regionprops(Bw(50,:));
%     index=[0 0];
%     totArea=0;
%     for j=1:length(stats)
%         totArea=totArea+stats(j).Area;
%     end
%     
%     for j=1:length(stats)
%         index=index+stats(j).Centroid*(stats(j).Area/totArea);
%     end
% 
%     subplot(234)
%     imshow(ImBlue), title('raw'); hold on;
%     plot(index(1), index(2), 's', 'color', 'red'); hold off;
% 
%     pause(0.01);
% end


%% Final Tracking Schema
close all
figure('name','thresholded data')
threeDtracker=[0,0,0];
threeDVel=[0,0,0];
threeDAccel=[0,0,0];
threshR=0.57; %bounce
threshL=0.57; %bounce
% threshL=0.3; % testDATA
% threshR=0.3; % testDATA
prevP=[0,0,0];
prevV=0;
S=strel('disk',9);
for i=460:1:length(listLeft)
%for i=490:1:(490+50)%length(listLeft)
%for i=610:(610+450)%length(listLeft)
    I_l=imread(listLeft(i).name);
    Image_left=rgb2ycbcr(I_l);
    Image_left_cr=Image_left(:,:,3);
    
    I_r=imread(listRight(i).name);
    Image_right=rgb2ycbcr(I_r);
    Image_right_cr=Image_right(:,:,3);
    
    Bw_left=im2bw(Image_left_cr,threshL);
    Bw_right=im2bw(Image_right_cr,threshR);
    
    Bw_left=imerode(Bw_left,S);
    Bw_left=imdilate(Bw_left,S);
    Bw_right=imerode(Bw_right,S);
    Bw_right=imdilate(Bw_right,S);
   
    %track LEFT
    stats=regionprops(Bw_left);
    index_left=[0 0];
    totArea=0;
    for j=1:length(stats)
        totArea=totArea+stats(j).Area;
    end
    
    for j=1:length(stats)
        index_left=index_left+stats(j).Centroid*(stats(j).Area/totArea);
    end
    
    stats=regionprops(Bw_right);
    index_right=[0 0];
    totArea=0;
    for j=1:length(stats)
        totArea=totArea+stats(j).Area;
    end
    
    for j=1:length(stats)
        index_right=index_right+stats(j).Centroid*(stats(j).Area/totArea);
    end
    
    % LEFT IMAGE IS CHOSEN BECAUSE IT IS THE ORIGIN
    subplot(231)
    imshow(I_l); title('Left Raw Image');

    
    subplot(232)
    imshow(I_l), title('Tracking Objects'); hold on;
    plot(index_left(1), index_left(2), 's', 'color', 'green'); hold on;
    plot(index_right(1), index_right(2), 's', 'color', 'red'); hold off;
    [p, v, a, prevP, prevV] = getPhysics(index_right(1), index_right(1),index_left(1),index_left(2),prevP,prevV);
    
    subplot(233)
    threeDVel=[threeDVel,v];
    %plot3(threeDtracker(:,1),threeDtracker(:,2),threeDtracker(:,3));
    % X plot
    plot(threeDVel(2:end),'-','Color','r'); hold on;
%     plot(threeDVel(2:end,2),'-','Color','g'); hold on;
%     plot(threeDVel(2:end,3),'-','Color','c'); hold on;
    title('Velocity Data')
    xlabel('sample')
    ylabel('Velocity (m/s)')
    xlim([30,120]);
    hold off;
    
    subplot(234)
    threeDtracker=[threeDtracker;p];
    %plot3(threeDtracker(:,1),threeDtracker(:,2),threeDtracker(:,3));
    % X plot
    plot(threeDtracker(2:end,1),'-','Color','r'); hold on;
    plot(threeDtracker(2:end,2),'-','Color','g'); hold on;
    plot(threeDtracker(2:end,3),'-','Color','c'); hold on;
    title('Position Data')
    xlabel('sample')
    ylabel('Position (m)')
%     xlim([10,30]);
    %legend('X','Y','Z');
    hold off;

    subplot(235)
    threeDAccel=[threeDAccel,a];
    %plot3(threeDtracker(:,1),threeDtracker(:,2),threeDtracker(:,3));
    % X plot
    plot(threeDAccel(2:end),'-','Color','r'); hold on;
    title('Acceleration Data')
    xlabel('sample')
    ylabel('Accel (m/s^2)')
%     xlim([10,30]);
    ylim([0,100]);
    hold off;

    
    pause(0.01);
end