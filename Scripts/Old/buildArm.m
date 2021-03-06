% Creazione braccio
d1 = 0.75;
d2 = 0.2;
d3 = 0.45;
d4 = 0.2;
d5 = 0.425;
d6 = 0.25;

ro = 2700; % Density
k = 5; % Scaling factor
ro = ro/k;

L(1) = Link([0 0 0 -pi/2]);
L(2) = Link([0 d2 d3 0]);
L(3) = Link([0 d4 0 -pi/2]);
L(4) = Link([0 d5 0 -pi/2]);
L(5) = Link([0 0 0 pi/2]);
L(6) = Link([0 d6 0 0]);

busher = SerialLink(L,'name','Busher');
busher.base = transl(0,0,d1);

q0 = zeros(1,6); % Zero position
qn = [0 -pi/4 0 0 pi/4 0]; % Nominal postion

T0 = busher.fkine(qn); % Posa iniziale relativa a qn

clear d* L