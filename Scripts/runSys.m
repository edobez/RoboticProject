%% Parameters

% Via points
T1 = transl(-0.4,0.5,0.8) * troty(-pi/2);
T2 = transl(-0.4,-0.5,0.8)* troty(-pi/2);
T3 = transl(-0.4,0,0.3)* troty(-pi/4);
T4 = transl(0,-0.8,0) * T0;

%% Simulazione
figure(1)
out = sim('System');
graphResults;