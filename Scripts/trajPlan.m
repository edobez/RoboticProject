% rimangono problemi quando attraversa il centro e quando non interseca il
% cerchio

clear, clc

Tmax = 30;
Ts = 0.5;
rad = 0.3;
delta = 0.1;
center = [0.2 0 0]';
x0 = [0.2 1 0]';
xf = [-0.2 -1 0.7]';
rpy0 = [0 0 0]';
rpyf = rpy0;

n = Tmax/Ts + 1;
T0 = transl(x0) * rpy2tr(rpy0');
Tf = transl(xf) * rpy2tr(rpyf');
T = ctraj(T0,Tf,n);

T0_1 = transl(center); % Hom. transformation from 0 to 1 (circle center)
T1_0 = inv(T0_1);

p0 = transl(T)'; % Cartesian pose in reference 0 (world)
p1 = T1_0*[p0;ones(1,n)];
p1 = p1(1:3,:);

polarDist = sqrt( p1(1,:).^2 + p1(2,:).^2);
innerPosIdx = find(polarDist <= rad);
innerPos = p1(:,innerPosIdx);
alfa = atan2(innerPos(2,end) - innerPos(2,1),innerPos(1,end) - innerPos(1,1)); %TODO: se non trova alcun punto interno da problemi
R = trotz(alfa);
T1_2 = R; % Hom. transformation from 1 to 2 (traj. line parallel to x-axis)
T2_1 = inv(T1_2);

p0c = p0; % Corrected cartesian position, to be modified in for loop

for i = innerPosIdx(1):innerPosIdx(end)

   p_1 = p1(:,i);
   p_2 = T2_1*[p_1;1];
   p_2 = p_2(1:3);
   
   c_2 = p_2;
   if p_2(2) >= 0
       c_2(2) = sqrt(rad^2-p_2(1)^2);
   else
       c_2(2) = -sqrt(rad^2-p_2(1)^2);
   end
   
   c_0 = T0_1*T1_2*[c_2;1];
   c_0 = c_0(1:3);
   
   p0c(:,i) = c_0;     
end

v = 0:0.1:2*pi;
circ = [rad*cos(v);rad*sin(v);zeros(1,length(v))];
circ = [circ;ones(1,length(v))];
circ = T0_1*circ;
circ = circ(1:3,:);

close all;
f = figure(1);
hold on;
plot(circ(1,:),circ(2,:),'k--')
scatter(p0(1,:),p0(2,:));
scatter(p0c(1,:),p0c(2,:));
scatter(center(1),center(2),'k*');
axis([-1 1 -1 1]);
hold off;

