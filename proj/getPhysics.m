function [p, v, a, prevP, prevV] = getPhysics(Rr, Cr, Rl, Cl, prevPos, prevVel);
    %knowns (from calibration)
    lambda=1e-3;
    Sx=1.2e-6;
    Sy=1.1e-6;
    u0=303;
    v0=260;
    %baseline=76e-3; %mm
    baseline=177.8e-3; %7 inches ish
    framerate=25;
    sampleTime=1/framerate;
    
    %triangulations
    Ul=(Rl-u0)*Sx;
    Ur=(Rr-u0)*Sx;
    Vl=(Cl-v0)*Sy;
    %Vr=(Cr-v0)*Sy;

 
    X=(baseline*Ul)/(Ul-Ur);
    Y=(baseline*Vl)/(Ul-Ur);
    Z=(lambda*baseline)/(Ul-Ur);
    
    
    p=zeros(1,3);
    v=zeros(1,3);
    a=zeros(1,3);

    dX=(X-prevPos(1))/sampleTime;
    dY=(Y-prevPos(2))/sampleTime;
    dZ=(Z-prevPos(3))/sampleTime;
    p=[X,Y,Z];

    %only measures magnitude of velocity, estimated using Euler's
    %approximation.
    v=sqrt((X-prevPos(1))^2+(Y-prevPos(2))^2+(Z-prevPos(3))^2)/sampleTime;
    
    %only measures magnitude of acceleration, estimated using Euler's
    %approximation.
    a=abs((v-prevVel)/sampleTime);

    
    prevP=p;
    prevV=v;

end