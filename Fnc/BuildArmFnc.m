function [robot] = BuildArmFnc()
%BuildArmFnc Summary of this function goes here
%   Detailed explanation goes here
% 
%  d1 = 0.735;
%  d2 = 0.14;
%  d3 = 0.64;
%  d4 = 0.20;
%  d5 = 0.775;
%  d6 = 0.4;

% nuovi valori di Bush
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

r = SerialLink(L,'name','Busher');
r.base = transl(0,0,d1);
robot = r;
end

