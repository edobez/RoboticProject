L(1) = Link([0 0 0 -pi/2]);
L(1).offset=pi/2;

L(2) = Link([0 0.14 0.64 pi]);

L(3) = Link([0 -0.20 0 pi/2]);
L(3).offset=pi/2;

L(4) = Link([0 0.775 0 -pi/2]);
L(4).offset=-pi/2;

L(5) = Link([0 0 0 pi/2]);
L(5).offset=-pi/2;

L(6) = Link([0 0.325 0 0]);
% L(6) = Link([0 0 0 0]);
L(6).offset=pi/2;

b6360 = SerialLink(L, 'name', 'Bush6360');

b6360.base = transl(0,0,0.735) * trotz(-pi/2);
% b6360.tool = transl(0,0,0.325);

% b6360.plot([0 0 0 0 0 0])

%six_link.plot([-pi/2 -pi/2 -pi/2 -pi/2 -pi/2 -pi/2])

% six_link.plot([pi/2 pi/2 pi/2 pi/2 pi/2 pi/2])

%six_link.plot([pi/4 pi/4 pi/4 pi/4 pi/4 pi/4])

%six_link.plot([-pi/4 -pi/4 -pi/4 -pi/4 -pi/4 -pi/4])