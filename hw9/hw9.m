% Pre processing
clear all, close all, clc;
%code for my custom functions can be found on 
%https://github.com/curtismuntz/machine_vision/tree/master/commonFunctions
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

figure('name','EquivDiameter')
clear A B C;
for i=1:10
    A(i)=Astats{i}.EquivDiameter;
    B(i)=Bstats{i}.EquivDiameter;
    C(i)=Cstats{i}.EquivDiameter;
end
plot(x, A, 's','color','green'), hold on
plot(x, B, 's','color','red'), hold on
plot(x, C, 's','color','blue'), hold on
xlabel('sample')
ylabel('EquivDiameter')
legend('A','B','C'), hold off



figure('name','EulerNumber')
clear A B C;
for i=1:10
    A(i)=Astats{i}.EulerNumber;
    B(i)=Bstats{i}.EulerNumber;
    C(i)=Cstats{i}.EulerNumber;
end
plot(x, A, 's','color','green'), hold on
plot(x, B, 's','color','red'), hold on
plot(x, C, 's','color','blue'), hold on
xlabel('sample')
ylabel('EulerNumber')
legend('A','B','C'), hold off




figure('name','FilledArea')
clear A B C;
for i=1:10
    A(i)=Astats{i}.FilledArea;
    B(i)=Bstats{i}.FilledArea;
    C(i)=Cstats{i}.FilledArea;
end
plot(x, A, 's','color','green'), hold on
plot(x, B, 's','color','red'), hold on
plot(x, C, 's','color','blue'), hold on
xlabel('sample')
ylabel('FilledArea')
legend('A','B','C'), hold off




figure('name','ConvexArea')
clear A B C;
for i=1:10
    A(i)=Astats{i}.ConvexArea;
    B(i)=Bstats{i}.ConvexArea;
    C(i)=Cstats{i}.ConvexArea;
end
plot(x, A, 's','color','green'), hold on
plot(x, B, 's','color','red'), hold on
plot(x, C, 's','color','blue'), hold on
xlabel('sample')
ylabel('ConvexArea')
legend('A','B','C'), hold off


figure('name','MinorAxisLength')
clear A B C;
for i=1:10
    A(i)=Astats{i}.MinorAxisLength;
    B(i)=Bstats{i}.MinorAxisLength;
    C(i)=Cstats{i}.MinorAxisLength;
end
plot(x, A, 's','color','green'), hold on
plot(x, B, 's','color','red'), hold on
plot(x, C, 's','color','blue'), hold on
xlabel('sample')
ylabel('MinorAxisLength')
legend('A','B','C'), hold off

figure('name','MajorAxisLength')
clear A B C;
for i=1:10
    A(i)=Astats{i}.MajorAxisLength;
    B(i)=Bstats{i}.MajorAxisLength;
    C(i)=Cstats{i}.MajorAxisLength;
end
plot(x, A, 's','color','green'), hold on
plot(x, B, 's','color','red'), hold on
plot(x, C, 's','color','blue'), hold on
xlabel('sample')
ylabel('MajorAxisLength')
legend('A','B','C'), hold off





%% Woo
% the graphs are analyzed to find good seperators, and then combined into
% multiple variable seperators. Perimeter seemed to seperate C's from the
% rest of the letters, and Extent seemed to seperate B's from the rest of
% the letters. Combining the two:


figure('name','Perim vs Extent')
clear A1 A2 B1 B2 C1 C2;
for i=1:10
    A1(i)=Astats{i}.Extent;
    B1(i)=Bstats{i}.Extent;
    C1(i)=Cstats{i}.Extent;
    A2(i)=Astats{i}.Perimeter;
    B2(i)=Bstats{i}.Perimeter;
    C2(i)=Cstats{i}.Perimeter;
end
plot(A1, A2, 's','color','green'), hold on
plot(B1, B2, 's','color','red'), hold on
plot(C1, C2, 's','color','blue'), hold on
xlabel('Extent')
ylabel('Perimteter')
legend('A','B','C'), hold off



figure('name','MajorAxisLength vs FilledArea')
clear A1 A2 B1 B2 C1 C2;
for i=1:10
    A1(i)=Astats{i}.FilledArea;
    B1(i)=Bstats{i}.FilledArea;
    C1(i)=Cstats{i}.FilledArea;
    A2(i)=Astats{i}.MajorAxisLength;
    B2(i)=Bstats{i}.MajorAxisLength;
    C2(i)=Cstats{i}.MajorAxisLength;
end
plot(A1, A2, 's','color','green'), hold on
plot(B1, B2, 's','color','red'), hold on
plot(C1, C2, 's','color','blue'), hold on
xlabel('FilledArea')
ylabel('MajorAxisLength')
legend('A','B','C'), hold off


figure('name','MajorAxisLength vs FilledArea vs Extent')
clear A1 A2 A3 B1 B2 B3 C1 C2 C3;
for i=1:10
    A1(i)=Astats{i}.FilledArea;
    B1(i)=Bstats{i}.FilledArea;
    C1(i)=Cstats{i}.FilledArea;
    A2(i)=Astats{i}.MajorAxisLength;
    B2(i)=Bstats{i}.MajorAxisLength;
    C2(i)=Cstats{i}.MajorAxisLength;
    A3(i)=Astats{i}.Extent;
    B3(i)=Bstats{i}.Extent;
    C3(i)=Cstats{i}.Extent;
end

plot3(A1, A2, A3, 's','color','green'), hold on
plot3(B1, B2, B3, 's','color','red'), hold on
plot3(C1, C2, C3, 's','color','blue'), hold on
xlabel('FilledArea')
ylabel('MajorAxisLength')
zlabel('Extent')
legend('A','B','C'), hold off

%% Creating Feature Sets
% now that we have a good set of seperators, we can combine these into a
% feature set. considering our equations are only defined in terms of two
% feature sets, we combine the known good seperators into a single feature set.




%% Perceptron for A
% Because the perceptron learning algorithm is a binary classifier, we have
% to stage the detections in order to solve for three classes. In this
% section, the perceptron algorithm is computed for the letter $A$ vs
% $notA$, and draws the resultant discrimination line for the
% classification. Because I will create three seperate perceptron weight
% and bias matricies, I wrote the algorithm as its own function: customPerceptron.m
close all;
trainingSet = 
threshold = %threshold to decide if the output is good or bad. usually this is 0
learningRate = 0.1;

[m n] = size(trainingSet);
weightVector = zeros(1,n-1);

iterationNo = 1;
% training phase
while true
   error_count = 0;
   for i=1:m,
      if trainingSet(i,1:n-1)*weightVector' > threshold
         result = 1;
      else
         result = 0;
      end

      error = trainingSet(i,n) - result;
      if error ~= 0
         error_count = error_count + 1;
         for j=1:n-1,
            if trainingSet(i,j) == 1
               weightVector(1,j) = weightVector(1,j) + error*learningRate;
            end
         end
      end
   end
   
   iterationNo = iterationNo +1;
   if iterationNo >= 1000
      disp('Neuron input calculation couldn''t completed in timely fashion.');
      return
   end 
   if error_count == 0
		break
   end
end
% get Sample result
testData = [ 1 0 1 ];

if testData * weightVector' > threshold
   disp('Result is an A.');
else
   disp('Result is 0.');
end


%% Perceptron for B
% This section will solve the perceptron algorithm for the letter $B$ vs
% $notB$ and draws the resultant discrimination line for the
% classificaition

%% Perceptron for C
% This section will solve the perceptron algorithm for the letter $C$ vs
% $notC$ and draws the resultant discrimination line for the
% classificaition

%%
%% Comparing our unknown set vs the perceptrons
% Before we run our code on the target set, we first have to normalize the
% size of the target letters. I've recorded the location of their centers
% such that we can dilate them back into the final image later.


x=[


[normalizeX,normalizeY]=size(objA{1})


%% Visualizing the Output
% redraw the output 
