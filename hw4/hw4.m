clear all;
clc;
close all;

addpath ../commonFunctions
I = getIMG(edgyIMG.jpg)
rmpath ../commonFunctions


sobelX=[-1 0 1; -2 0 2; -1 0 1]
sobelY=[1 2 1; 0 0 0; -1 -2 -1]

