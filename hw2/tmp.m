clear all
clc

image=[4,4,3,5,4;
    6,6,5,5,2;
    5,6,6,6,2;
    6,7,5,5,3;
    3,5,2,4,4];
mask=[0, -1, 0;
    -1, 4, -1;
    0, -1, 0];

Builtin = conv2(image,mask,'same')
I = convolution(image,mask)