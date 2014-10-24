clear, clc, close all;

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

T1 = transl(0,0.2,0) * T0;
T2 = transl(0,0,-0.3) * T1;
T3 = transl(0,-0.2,0) * T2;

%% Simulazione

out = sim('System');
graphResults;