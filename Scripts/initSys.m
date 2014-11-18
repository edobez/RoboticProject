clear, clc
s = tf('s');
startup_rvc;

%% Physical dimensions definition
% Every dimension MUST be written in the mks units!

% Density of links, scaled in order to get pipe instead of solid cylinder
dim.ro = 2700/5; % Density [kg/m^3]
dim.radius = 50e-3;
dim.L1 = 225e-3;
dim.L2 = 600e-3;
dim.Lc = 150e-3;
dim.L3 = 400e-3;
dim.L4 = 100e-3;
dim.L5 = 100e-3;
dim.L6 = 100e-3;
G = 9.81;

%% Arm generation
d1 = 0.75;
d2 = 0.2;
d3 = 0.45;
d4 = 0.2;
d5 = 0.425;
d6 = 0.25;

L(1) = Link([0 0 0 -pi/2]);
L(1).m = 4;
L(2) = Link([0 d2 d3 0]);
L(3) = Link([0 d4 0 -pi/2]);
L(4) = Link([0 d5 0 -pi/2]);
L(5) = Link([0 0 0 pi/2]);
L(6) = Link([0 d6 0 0]);

robot = SerialLink(L,'name','Busher');
robot.base = transl(0,0,d1);

% q0 = zeros(1,6);            % Zero position
% qn = [0 -pi/4 0 0 pi/4 0];  % Nominal postion
% T0 = robot.fkine(qn);       % Nominal pose

clear L                  % Clear unnedded variables

%% Parametri

Tjoint = 0.05;
Tpid = 0.05;
Kp = 2;
Ki = 1;
J = 0.01;
B = 0.1;
Km = 0.25;
Kv = 0.8;
tau_max = 0.9;

Mimo = eye(6) * (1/(J*s + B));