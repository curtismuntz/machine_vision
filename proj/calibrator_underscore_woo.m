%% Preprocessing
clear all; close all; clc;

%set(0,'DefaultFigureWindowStyle','docked');

base_dir = 'C:\Users\me\Desktop\zzzGOODATA\calibration\cal_may8';
cd(base_dir);

imageLeft=imread('video0_calib_0.jpg');
imageRight=imread('video1_calib_0.jpg');

figure('name','Left Image');
imshow(imageLeft)

figure('name','Right Image');
imshow(imageRight)

%%
close all
% values gathered manually by inspection:
% array is in form (r,c)
LEFTCAM=[181,294;
		219,295;
		261,295;
		300,296;
		344,297;
		385,297;
		431,298;
		475,299;

		180,253;
		221,253;
		260,253;
		302,253;
		343,253;
		387,253;
		430,253;
		477,253;

		182,211;
		220,211;
		262,210;
		301,210;
		344,210;
		387,210;
		431,209;
		476,208;

		182,170;
		221,170;
		261,169;
		302,168;
		344,167;
		387,166;
		431,165;
		477,163;]

RIGHTCAM=[101,302;
		138,302;
		177,303;
		216,303;
		256,304;
		297,304;
		340,305;
		383,305;

		102,261;
		139,261;
		177,260;
		217,260;
		256,260;
		298,260;
		340,260;
		384,260;

		103,219;
		140,219;
		178,219;
		217,218;
		257,217;
		298,216;
		341,215;
		384,214;

		103,179;
		141,178;
		178,177;
		217,176;
		257,174;
		298,173;
		340,171;
		384,169;]
figure('name','r,c plane');
plot(LEFTCAM(:,1),LEFTCAM(:,2),'s'), title('r,c plane');

%%
%close all;
Re=zeros(32,3);
square=25.87;
y=-21.53-square;

for k=1:4
    x=-103.48;
    z=508;
    y=y+square;
    
    for n=1:8
        z=z-(55.56/232.13);
        x=x+square;
            Re(8*(k-1)+n,1)=x;
            Re(8*(k-1)+n,2)=y;
            Re(8*(k-1)+n,3)=z;
    end
end
figure('name','real world');
plot3(Re(:,1),Re(:,2),Re(:,3),'s')


%% Solving for intrinsic parameters
% Ax=0;
close all;
rl=[(LEFTCAM(:,1).*Re(:,3)),-Re(:,3),-Re(:,1)];
cl=[(LEFTCAM(:,2).*Re(:,3)),-Re(:,3),-Re(:,2)];
A=[rl];
[U,D,V]=svd(A);
Xleft_x=V(:,end);

A=[cl];
[U,D,V]=svd(A);
Xleft_y=V(:,end);

rr=[(RIGHTCAM(:,1).*Re(:,3)),-Re(:,3),-Re(:,1)];
cr=[(RIGHTCAM(:,2).*Re(:,3)),-Re(:,3),-Re(:,2)];
A=[rr];
[U,D,V]=svd(A);
Xright_x=V(:,end)

A=[cr];
[U,D,V]=svd(A);
Xright_y=V(:,end)


% %% AX=B
% close all;
% Br=LEFTCAM(:,1).*Re(:,3); % r*Z
% Bc=LEFTCAM(:,2).*Re(:,3); % c*Z
% A1=[Re(:,3),Re(:,1)];
% A2=[Re(:,3),Re(:,2)];
% 
% X1=(inv(A1'*A1)*A1'*Br)
% X2=(inv(A2'*A2)*A2'*Bc)

