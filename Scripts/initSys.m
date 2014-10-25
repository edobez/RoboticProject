clear, clc

%% Script di inizializzazione
s = tf('s');
buildArm;
robot = busher; % serve a far funzionare il modello Sim

%% Parametri
% TODO - mettere queste variabili in una struttura, così non sporca troppo
% il workspace
Kp = 2;
Ki = 1;
J = 0.01;
B = 0.1;
Km = 0.228;
Kv = 0.8;
tau_max = 0.9;

Mimo = eye(6) * (1/(J*s + B));

T1 = transl(-0.4,0.5,0.8) * troty(-pi/2);
T2 = transl(-0.4,-0.5,0.8)* troty(-pi/2);
T3 = transl(-0.4,0,0.3)* troty(-pi/4);

%% Simulazione
figure(1)
out = sim('System');
graphResults;