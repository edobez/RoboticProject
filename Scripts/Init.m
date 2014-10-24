clear, clc, close all;

%% Script di inizializzazione
robot = BuildArmFnc()

q0 = ones(1,6); % Zero position
qn = [0 -pi/4 0 0 pi/4 0]; % Nominal postion

T0 = robot.fkine(qn);
%inizializzazione parametri motore
Kp = 2;
Ki = 1;
J = 0.01;
B = 0.1;
Km = 0.228;
Kv =0.8;
tau_max = 0.9;
s = tf('s');
Mimo = eye(6) * (1/(J*s + B));