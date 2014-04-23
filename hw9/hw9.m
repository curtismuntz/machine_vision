% Pre processing
clear all; close all; clc;
%code for my custom functions can be found on 
%https://github.com/curtismuntz/machine_vision/tree/master/commonFunctions
addpath ../commonFunctions
I1=getIMG('mvHW9A.jpg'); % <- learning set
I1=im2bw(I1);
I1=imclose(I1,strel('diamond',2));
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

x=1:1:10;
figure('name','Area')
A=zeros(1,10);
B=zeros(1,10);
C=zeros(1,10);
for i=1:10
    A(i)=Astats{i}.Area;
    B(i)=Bstats{i}.Area;
    C(i)=Cstats{i}.Area;
end
plot(x,A,'s','color','green'), hold on
plot(x,B, 's','color','red'), hold on
plot(x,C,'s','color','blue')
xlabel('sample')
ylabel('Area')
legend('A','B','C'), hold off


figure('name','Perimiter')
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


figure('name','Solidity')
for i=1:10
    A(i)=Astats{i}.Solidity;
    B(i)=Bstats{i}.Solidity;
    C(i)=Cstats{i}.Solidity;
end
plot(x, A, 's','color','green'), hold on
plot(x, B, 's','color','red'), hold on
plot(x, C, 's','color','blue'), hold on
xlabel('sample')
ylabel('Solidity')
legend('A','B','C'), hold off



figure('name','Centroid Magnitude')
for i=1:10
    A(i)=sqrt(Astats{i}.Centroid(1)^2 + Astats{i}.Centroid(2)^2);
    B(i)=sqrt(Bstats{i}.Centroid(1)^2 + Bstats{i}.Centroid(2)^2);
    C(i)=sqrt(Cstats{i}.Centroid(1)^2 + Cstats{i}.Centroid(2)^2);
end
plot(x, A, 's','color','green'), hold on
plot(x, B, 's','color','red'), hold on
plot(x, C, 's','color','blue'), hold on
title('Centroid Magnitude')
xlabel('sample')
ylabel('Centroid Magnitude')
legend('A','B','C'), hold off

figure('name','Average Extrema')
for i=1:10
    A(i)=mean(mean(Astats{i}.Extrema));
    B(i)=mean(mean(Bstats{i}.Extrema));
    C(i)=mean(mean(Cstats{i}.Extrema));
end
plot(x, A, 's','color','green'), hold on
plot(x, B, 's','color','red'), hold on
plot(x, C, 's','color','blue'), hold on
xlabel('sample')
ylabel('Centroid Magnitude')
legend('A','B','C'), hold off

%% Woo
% the graphs are analyzed to find good seperators, and then combined into
% multiple variable seperators. Perimeter seemed to seperate C's from the
% rest of the letters, and Extent seemed to seperate B's from the rest of
% the letters. Combining the two:
A1=zeros(1,10);
A2=A1; A3=A1; B1=A1; B2=A1; B3=A1; C1=A1; C2=A1; C3=A1;

figure('name','Perim vs Extent')
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


figure('name','MajorAxisLength vs EulerNumber')
for i=1:10
    A1(i)=Astats{i}.EulerNumber;
    B1(i)=Bstats{i}.EulerNumber;
    C1(i)=Cstats{i}.EulerNumber;
    A2(i)=Astats{i}.MajorAxisLength;
    B2(i)=Bstats{i}.MajorAxisLength;
    C2(i)=Cstats{i}.MajorAxisLength;
end
plot(A1, A2, 's','color','green'), hold on
plot(B1, B2, 's','color','red'), hold on
plot(C1, C2, 's','color','blue'), hold on
xlabel('EulerNumber')
ylabel('MajorAxisLength')
legend('A','B','C'), hold off


figure('name','Extent vs EulerNumber')
for i=1:10
    A1(i)=Astats{i}.EulerNumber;
    B1(i)=Bstats{i}.EulerNumber;
    C1(i)=Cstats{i}.EulerNumber;
    A2(i)=Astats{i}.Extent;
    B2(i)=Bstats{i}.Extent;
    C2(i)=Cstats{i}.Extent;
end
plot(A1, A2, 's','color','green'), hold on
plot(B1, B2, 's','color','red'), hold on
plot(C1, C2, 's','color','blue'), hold on
xlabel('EulerNumber')
ylabel('Extent')
legend('A','B','C'), hold off

figure('name','MajorAxisLength vs FilledArea vs Extent')
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


trainingSetA= zeros(30,2);
resultSetA = zeros(30,1);
for i=1:10
    m=1;
    trainingSetA(i,m)   = Astats{i}.Extent;
    trainingSetA(i,m+1) = Astats{i}.EulerNumber;
    resultSetA(i)       = 1;
end
for i=11:20
    m=1;
    trainingSetA(i,m)   = Bstats{i-10}.Extent;
    trainingSetA(i,m+1) = Bstats{i-10}.EulerNumber;
end
for i=21:30
    m=1;
    trainingSetA(i,m)   = Cstats{i-20}.Extent;
    trainingSetA(i,m+1) = Cstats{i-20}.EulerNumber;
end


trainingSetB= zeros(30,2);
resultSetB = zeros(30,1);
for i=1:10
    m=1;
    trainingSetB(i,m)   = Astats{i}.Extent;
    trainingSetB(i,m+1) = Astats{i}.EulerNumber;
end
for i=11:20
    m=1;
    trainingSetB(i,m)   = Bstats{i-10}.Extent;
    trainingSetB(i,m+1) = Bstats{i-10}.EulerNumber;
    resultSetB(i) = 1; % these are A's so we should switch their desired output to 1!!!
end
for i=21:30
    m=1;
    trainingSetB(i,m)   = Cstats{i-20}.Extent;
    trainingSetB(i,m+1) = Cstats{i-20}.EulerNumber;
end


trainingSetC= zeros(30,2);
resultSetC = zeros(30,1);
for i=1:10
    m=1;
    trainingSetC(i,m)   = Astats{i}.Perimeter;
    trainingSetC(i,m+1) = Astats{i}.EulerNumber;
    %trainingSetC(i,m)    = Astats{i}.MajorAxisLength;
    %trainingSetC(i,m+1)  = Astats{i}.FilledArea;
end
for i=11:20
    m=1;
    trainingSetC(i,m)   = Bstats{i-10}.Perimeter;
    trainingSetC(i,m+1) = Bstats{i-10}.EulerNumber;
end
for i=21:30
    m=1;
    trainingSetC(i,m)   = Cstats{i-20}.Perimeter;
    trainingSetC(i,m+1) = Cstats{i-20}.EulerNumber;
    resultSetC(i) = 1; % these are C's so we should switch their desired output to 1!!!

end


%% Perceptron for C
% Because the perceptron learning algorithm is a binary classifier, we have
% to stage the detections in order to solve for three classes. In this
% section, the perceptron algorithm is computed for the letter $B$ vs
% $notB$, and draws the resultant discrimination line for the
% classification.
close all; clc;
%build training set

[m, n] = size(trainingSetC);
weightVector = ones(1,n);
for i=1:n
    weightVector(i) = weightVector(i)./(5); %initialize to small numbers. 12 guaranteed to be random, it was chosen through a set of dice rolls.
end

%weightVector = zeros(1,n);
threshold = 0;%threshold to decide if the output is good or bad. usually this is 0
error_count = 1;
bias = 0.1;
result = 1;
iterationNo = 1;
learningRate = 0.001;
% training phase
while (error_count > 0)
	error_count = 0;
	for i=1:m
        gx=dot(weightVector,trainingSetC(i,:))+bias;
            if (gx > threshold)
                result = 1;
            else
                result = 0;
            end

            error = resultSetC(i)-result;
            if (error ~= 0)
                error_count = error_count + 1;
                weightVector = weightVector + (learningRate*(error))*trainingSetC(i,1:n);
                bias = bias + learningRate*error;
            end
    end
    
	if (iterationNo >= 1000)
        disp('Neuron input calculation couldn''t completed in timely fashion.');
        break
    end
	iterationNo = iterationNo +1;
end
disp(['answer converged in ' num2str(iterationNo) ' iterations']);

% get Sample result
disp(['weights: ' num2str(weightVector)]);
disp(['bias: ' num2str(bias)]);
gxA=0;
gx=0;
for k=1:10
    %testing training set data:
    testDataC = trainingSetC(k+20,:);
    gxC=dot(weightVector,testDataC)+bias;
    
    testDataA = trainingSetC(k,:);
    gx=dot(weightVector,testDataA)+bias;
       
    fprintf('\n');
    if  gxC > threshold
       fprintf(['Result is C. %s\n ' num2str(gxC)]); 
    else
       fprintf(2,['Result is not a C. %s\n ' num2str(gxC)]); % result is not expected
    end
    fprintf('\n');
    if gx > threshold
       fprintf(2,['Result is C. %s\n ' num2str(gx)]);
    else
       fprintf(['Result is not a C. %s\n ' num2str(gx)]); %result is not expected
    end
    fprintf('\n-----');
end


%% Perceptron for B
% This section will solve the perceptron algorithm for the letter $B$ vs
% $notB$ and draws the resultant discrimination line for the
% classificaition
%function [weightVector, bias] = customPerceptron(trainingSet)
addpath ../commonFunctions;
[weightVectorB, biasB] = customPerceptron(trainingSetB, resultSetB);
rmpath ../commonFunctions;

disp(['weights: ' num2str(weightVectorB)]);
disp(['bias: ' num2str(biasB)]);
gxB=0;
gx=0;
for k=1:10
    %testing training set data:
    testDataB = trainingSetB(k+10,:);
    gxB=dot(weightVectorB,testDataB)+biasB;
    testDataA = trainingSetB(k,:);
    gx=dot(weightVectorB,testDataA)+biasB;
       
    fprintf('\n');
    if  gxB > threshold
       fprintf(['Result is B. %s\n ' num2str(gxB)]); 
    else
       fprintf(2,['Result is not a B. %s\n ' num2str(gxB)]); %result is not expected
    end
    fprintf('\n');
    if gx > threshold
       fprintf(2,['Result is B. %s\n ' num2str(gx)]);% result is not expected
    else
       fprintf(['Result is not a B. %s\n ' num2str(gx)]); 
    end
    fprintf('\n-----');
end
%% Perceptron for A
% This section will solve the perceptron algorithm for the letter $A$ vs
% $notA$ and draws the resultant discrimination line for the
% classificaition
addpath ../commonFunctions;
[weightVectorA, biasA] = customPerceptron(trainingSetA, resultSetA);
rmpath ../commonFunctions;

disp(['weights: ' num2str(weightVectorA)]);
disp(['bias: ' num2str(biasA)]);

%testing training set data:
gxA=0;
gx=0;
for k=1:10
    testDataA = trainingSetA(k,:);
    gxA=dot(weightVectorA,testDataA)+biasA;
    testDataB = trainingSetA(k+10,:);
    gx=dot(weightVectorA,testDataB)+biasA;
       
    fprintf('\n');
    if  gxA > threshold
       fprintf(['Result is A. %s\n ' num2str(gxA)]); 
    else
       fprintf(2,['Result is not an A. %s\n ' num2str(gxA)]); %result is not expected
    end
    fprintf('\n');
    if gx > threshold
       fprintf(2,['Result is A. %s\n ' num2str(gx)]);% result is not expected
    else
       fprintf(['Result is not an A. %s\n ' num2str(gx)]); 
    end
    fprintf('\n-----');
end
%%
%% Comparing our unknown set vs the perceptrons
% Before we run our code on the target set, we first have to normalize the
% size of the target letters. I've recorded the location of their centers
% such that we can dilate them back into the final image later.
clear testDataA testDataB testDataC 
%load images
%clean images up
%resize images
imresize(test)

% x=[
% 
% 
% [normalizeX,normalizeY]=size(objA{1})
% 

%% Visualizing the Output
% redraw the output 
