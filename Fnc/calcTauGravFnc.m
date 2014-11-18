function [ tauFf ] = calcTauGravFnc( q,dim )
%CALCTAUGRAVFNC Calculates the torques due to gravity in a given arm
%configuration
% q = arm configuration
% dim = struct with dimensions of arm
% tauFf = torque (approximated) at each join in order to balance gravity

G=9.81;

M2 = pi*dim.radius^2 * dim.L2 * dim.ro;
M3 = pi*dim.radius^2 * (dim.Lc + 5e-2) * dim.ro;
M34 = pi*dim.radius^2 * (dim.L3 + dim.L4) * dim.ro; % link 3 e 4 come monoblocco rispetto alla gravità
M5 = pi*dim.radius^2 * (dim.L5) * dim.ro;
M6 = pi*dim.radius^2 * (dim.L6) * dim.ro;

q3_offset = pi/2;

Fp2 = M2 * G;
Fpc3 = M3 * G;
Fp34 = M34 * G;% link 3 e 4 come monoblocco rispetto alla gravità
Fp5 = M5 * G;
Fp6 = M6 * G;
Fp56 = Fp5 + Fp6;

dist_2_3 = dim.L2-15e-2;
dist_2_cm2 = (dim.L2/2)-7.5e-2;
dist_3_cm3 = (dim.L3+dim.L4)/2-7.5e-2;
dist_3_56 = dim.L3+dim.L4-7.5e-2;

%TXY, Coppia applicata al motore X dal corpo Y;
T2_2 = dist_2_cm2*cos(q(2))*Fp2;
T2_c3 = dist_2_3*cos(q(2))*Fpc3;
T2_46 = (dist_2_3*cos(q(2))+ dist_3_cm3*cos(q(2)+q(3)+q3_offset))*Fp34;
T2_56 = (dist_2_3*cos(q(2))+ dist_3_56*cos(q(2)+q(3)+q3_offset))*Fp56;
T3_34 = dist_3_cm3 * cos(q(2)+q(3)+q3_offset)* Fp34;
T3_56 = dist_3_56 * cos(q(2)+q(3)+q3_offset)*(Fp56);

tauFf(1)=0;
tauFf(2) = -(T2_2+T2_c3+T2_46+T2_56);
tauFf(3) = -(T3_34+T3_56);
tauFf(4)=0;
tauFf(5)=0;
tauFf(6)=0;

end

