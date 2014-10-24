% Creazione braccio

d1 = 0.725;
d2 = 0.175;
d3 = 0.45;
d4 = 0.175;
d5 = 0.325;
d6 = 0.15;

L(1) = Link([0 0 0 -pi/2]);
L(2) = Link([0 d2 d3 0]);
L(3) = Link([0 d4 0 -pi/2]);
L(4) = Link([0 d5 0 -pi/2]);
L(5) = Link([0 0 0 pi/2]);
L(6) = Link([0 d6 0 0]);

busher = SerialLink(L,'name','Busher');
busher.base = transl(0,0,d1);
%trotz(-pi/2)
busher.plot([0 0 0 0 0 0])
busher.fkine([0 0 0 0 0 0])
%busher.fkine([-pi/2 -pi/2 -pi/2 -pi/2 -pi/2 -pi/2])

q0 = zeros(1,6);