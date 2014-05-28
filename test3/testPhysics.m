function [p] = testPhysics(stereoParams, imageCoords);
    %knowns (from calibration)
    lambda=stereoParams.lambda;
    Sx=stereoParams.Sx;
    Sy=stereoParams.Sy;
    u0=stereoParams.u0;
    v0=stereoParams.v0;
    baseline=stereoParams.baseline;

    % IMAGE COORDINATES ARE IN FORM [leftR, leftC, rightR, rightC]
    Rl=imageCoords(1);
    Cl=imageCoords(2);
    Rr=imageCoords(3);
    %Cr=imageCoords(4);

    
    %triangulations
    Ul=(Rl-u0)*Sx;
    Ur=(Rr-u0)*Sx;
    Vl=(Cl-v0)*Sy;
    %Vr=(Cr-v0)*Sy;
 
    X=(baseline*Ul)/(Ul-Ur);
    Y=(baseline*Vl)/(Ul-Ur);
    Z=(lambda*baseline)/(Ul-Ur);
    
    
    p=[X,Y,Z];


end