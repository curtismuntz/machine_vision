% Pre processing
clear all, close all, clc;
addpath ../commonFunctions
I1=getIMG('mvHW9A.jpg'); % <- learning set
I1=im2bw(I1);
range=[91,37,1317,320];
I1=imcrop(I1, range);
I2=getIMG('mvHW9B.jpg'); % <- testing image
I2=imcomplement(im2bw(I2)); % objects need to be white
%cleanI=majorityfilter(I2);
cleanI=I2;
rmpath ../commonFunctions
%setSTATS=regionprops(I1,'all');
%testSTATS=regionprops(I2,'all'); %<- note that the objects are black in I2


imshow(I1);
figure
imshow(cleanI);
%% woo
% grab data points
close all
figure('name','A objects');

x=0; %start of object x=0 (because of cropping) x+=134
y=0; %start of object y=0 (because of cropping) y+=110
%there are 10 objects
objA={zeros(10)};
Astats={zeros(10)};

for i=1:10
    subplot(2,5,i)
    objRange=[x,y,110,110];
    objA{i}=imcrop(I1, objRange);
    Astats{i}=regionprops(objA{i},'all');
    imshow(objA{i})
    x=x+134;
end

% avgCentroidA     = [mean(centAx),mean(centAy)]
% avgAreaA         = mean(areaA)
% avgEccentricityA = mean(eccA)
% avgFilledAreaA   = mean(filledA)


figure('name','B objects');
x=0;
y=y+110;
%there are 10 objects
objB={zeros(10)};
Bstats={zeros(10)};

for i=1:10
    subplot(2,5,i)
    objRange=[x,y,110,110];
    objB{i}=imcrop(I1, objRange);
    Bstats{i}=regionprops(objB{i},'all');
    imshow(objB{i})
    x=x+134;
end
% last B sucks.
strellion=strel('disk',2)
objB{10}=imdilate(objB{10},strellion)
Bstats{10}=regionprops(objB{10},'all');
imshow(objB{10});

figure('name','C objects');
x=0;
y=y+110;
%there are 10 objects
objC={zeros(10)};
Cstats={zeros(10)};

for i=1:10
    subplot(2,5,i)
    objRange=[x,y,110,110];
    objC{i}=imcrop(I1, objRange);
    Cstats{i}=regionprops(objC{i},'all');
    imshow(objC{i})
    x=x+134;
end


%% 
close all

x=[1,2,3,4,5,6,7,8,9,10];
figure('name','Area')
for i=1:10
    A(i)=Astats{i}.Area;
    B(i)=Bstats{i}.Area;
    C(i)=Cstats{i}.Area;
end
plot(x,A,'s','color','green'), hold on
plot(x,B, 's','color','red'), hold on
plot(x,C,'s','color','blue'), hold on
xlabel('sample')
ylabel('Area')
legend('A','B','C'), hold off


figure('name','Perimiter')
clear A B C;
for i=1:10
    A(i)=Astats{i}.Perimeter;
    B(i)=Bstats{i}.Perimeter;
    C(i)=Cstats{i}.Perimeter;
end
plot(x,A,'s','color','green'), hold on
plot(x,B, 's','color','red'), hold on
plot(x,C,'s','color','blue'), hold on
xlabel('sample')
ylabel('Perimeter')
legend('A','B','C'), hold off

figure('name','Extent')
clear A B C;
for i=1:10
    A(i)=Astats{i}.Extent;
    B(i)=Bstats{i}.Extent;
    C(i)=Cstats{i}.Extent;
end
plot(x, A, 's','color','green'), hold on
plot(x, B, 's','color','red'), hold on
plot(x, C, 's','color','blue'), hold on
xlabel('sample')
ylabel('Extent')
legend('A','B','C'), hold off


figure('name','BoundingBox Area')
clear A B C;
%where bounding box areas are the heights* widths (BB(3)*BB(4))
for i=1:10
    A(i)=((Astats{i}.BoundingBox(3))*(Astats{i}.BoundingBox(4)));
    B(i)=((Bstats{i}.BoundingBox(3))*(Bstats{i}.BoundingBox(4)));
    C(i)=((Cstats{i}.BoundingBox(3))*(Cstats{i}.BoundingBox(4)));
end
plot(x, A, 's','color','green'), hold on
plot(x, B, 's','color','red'), hold on
plot(x, C, 's','color','blue'), hold on
xlabel('sample')
ylabel('Bounding Box Area')
legend('A','B','C'), hold off

%% Woo
% the graphs are analyzed to find 



%% NN
% see http://www.mathworks.com/matlabcentral/fileexchange/32949-a-perceptron-learns-to-perform-a-binary-nand-function/content/PerceptronImpl.m
