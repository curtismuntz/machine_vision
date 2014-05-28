%% Preprocessing
clear all; close all; clc;

set(0,'DefaultFigureWindowStyle','docked');

%Curtis' directory
base_dir = 'C:\Users\me\Desktop\zzzGOODATA\lastTest';

%David's directory
% base_dir = 'C:\Users\David\Desktop\SHAREDPROJECT\zzzGOODATA\lastTest';
cd(base_dir);

%% frame listings
listLeft =  dir('left*');
listRight= dir('right*');


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

i=600;

for i=610:1:(610+400)%length(listLeft)
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
    ylim([0,20]);
%     xlim([30,120]);
    hold off;
    
    subplot(234)
    threeDtracker=[threeDtracker;p];
    %plot3(threeDtracker(:,1),threeDtracker(:,2),threeDtracker(:,3));
    % X plot
    plot(threeDtracker(2:end,1),'-','Color','r'); hold on;
    plot(threeDtracker(2:end,2),'-','Color','g'); hold on;
    plot(threeDtracker(2:end,3),'-','Color','c'); hold on;
    title('Position Data')
    xlabel('X:Red, Y:Green, Z:Cyan')
    ylabel('Position (m)')
%     xlim([10,30]);
    %legend('X','Y','Z');
    hold off;

    subplot(235)
    threeDAccel=[threeDAccel,a];
    plot3(threeDtracker(:,1),threeDtracker(:,2),threeDtracker(:,3),'+');
    % X plot
%     plot(threeDAccel(2:end),'-','Color','r'); hold on;
%     title('Acceleration Data')
%     xlabel('sample')
%     ylabel('Accel (m/s^2)')
% %     xlim([10,30]);
%     ylim([0,100]);
%     hold off;

    
    pause(0.01);
end