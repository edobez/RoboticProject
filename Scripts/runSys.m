%% Parameters

% Via points
T1 = transl(-0.4,0.5,0.8) * troty(-pi/2);
T2 = transl(-0.4,-0.5,0.8)* troty(-pi/2);
T3 = transl(-0.4,0,0.3)* troty(-pi/4);
T4 = transl(0,-0.8,0) * T0;

P0 = [0.7071    -0.7071    0        0.25,
      0.7071    0.7071     0       -0.25,
      0         0          1.0000   0.05,
      0         0          0        1];
  
P2 = [0.5000   -0.7071    0.5000    0.6,
      0.5000    0.7071    0.5000    0.6,
     -0.7071         0    0.7071    0.5,
      0              0    0         1];  
  
P3 = [0.5000   -0.7071    0.5000    0.8,
      0.5000    0.7071    0.5000    0.8,
     -0.7071         0    0.7071    0.3,
      0              0    0         1];

%% Simulazione
figure(1)
out = sim('System');
graphResults;