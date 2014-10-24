clear, clc

Tmax = 30;
Ts = 0.5;
rad = 0.3;
delta = 0.1;
center = [0.1 0.3 0]';
x0 = [1 0.3 0]';
xf = [-1 0 0.7]';
rpy0 = [0 0 0]';
rpyf = rpy0;

n = Tmax/Ts + 1;
T0 = transl(x0) * rpy2tr(rpy0');
Tf = transl(xf) * rpy2tr(rpyf');
T = ctraj(T0,Tf,n);
Tc = T;

for i = 2:n
   Tc(:,:,i) = avoidPoint(T(:,:,i), T(:,:,i-1),center,rad);
end

p0 = transl(T)';
p0c = transl(Tc)';

T0_1 = transl(center); % Hom. transformation from 0 to 1 (circle center)
v = 0:0.1:2*pi;
circ = [rad*cos(v);rad*sin(v);zeros(1,length(v))];
circ = [circ;ones(1,length(v))];
circ = T0_1*circ;
circ = circ(1:3,:);

close all;
hold on;
plot(circ(1,:),circ(2,:),'k--')
scatter(p0(1,:),p0(2,:));
scatter(p0c(1,:),p0c(2,:));
scatter(center(1),center(2),'k*');
axis([-1 1 -1 1]);
hold off;

