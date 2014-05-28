function [p] = testPhysics_alphas(stereoParams, imageCoords);
    %knowns (from calibration)
    alpha_v=stereoParams.alpha_v;
    alpha_u=stereoParams.alpha_u;
    u0=stereoParams.u0;
    v0=stereoParams.v0;
    baseline=stereoParams.baseline;

    % IMAGE COORDINATES ARE IN FORM [leftR, leftC, rightR, rightC]
    Rl=imageCoords(1);
    Cl=imageCoords(2);
    Rr=imageCoords(3);
    %Cr=imageCoords(4);

    
    %triangulations
    nUl=(Rl-u0)*(alpha_v/alpha_u);
    nUr=(Rr-u0)*(alpha_v/alpha_u);
    nVl=(Cl-v0)*(alpha_u/alpha_v);
    %Vr=(Cr-v0)*Sy;
    Z=(alpha_v*baseline)/(nUl-nUr);
    X=((Rl-u0)*Z)/alpha_u;
    Y=((Cl-v0)*Z)/alpha_v;
    p=[X,Y,Z];


end