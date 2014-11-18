%% Parameters
q0 = [0 -pi/8 0 0 pi/4 0];% Posa Alta
qn=q0;
q_start = [0 pi/2 -pi*5/6 0 pi/6 0];     % Starting point
    
q1 = [0 0 0 0 pi/4 0];% q per prendere la pallina

qAI = [-pi*3/4 -pi/4 -pi/6 0 pi/4 0]
qAF = [-pi -pi/4 0 0 pi/4 0]

%% Via points
T0 = robot.fkine(q0);                             
T1 = trotz(-pi/4) * robot.fkine(q1);
T2 = trotz(-pi/2) * T0;
T3 = robot.fkine(qAI);
T4 = robot.fkine(qAF);
T5 = trotz(-pi/4) * robot.fkine(q_start);
TF = robot.fkine(q_start);

%% Simulazione

% out = sim('SystemT');
