L(1) = Link([0 0 0 -pi/2]);
L(1).offset=pi/2;   

L(2) = Link([0 0.14 0.64 pi]);

L(3) = Link([0 -0.20 0 pi/2]);
L(3).offset=pi/2;

L(4) = Link([0 0.775 0 pi/2]);
L(4).offset=pi/2;

L(5) = Link([0 0 0 pi/2]);

L(6) = Link([0 0.325 0  pi/2]);

six_link = SerialLink(L, 'name', 'Bush6360')

six_link.plot([0 0 0 0 0 0])
qn=[0 pi/4 pi 0 pi/4  0];