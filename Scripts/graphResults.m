%% Acquisizione dati da output modello
pose.sp = transl(out.get('Tsp'));
pose.plan = transl(out.get('Tplan'));

q.sprad = out.get('q');
q.sp = out.get('q')*180/pi;
q.dot = out.get('qdot')*180/pi;
q.dot = q.dot(1:length(q.sp),:);
q.man = robot.maniplty(q.sprad);

t = out.get('tout');
t = t(1:length(q.sp));

%% Grafico proiezioni traiettorie
scrsz = get(groot,'ScreenSize');
f2 = figure(2);
set(f2,'OuterPosition',[1 50 scrsz(3)/4 (scrsz(4) - 50)]);
clf(f2)

% XY
subplot(3,1,1)
hold on
title('XY graph')
xlabel('X-axis')
ylabel('Y-axis')
plot(pose.plan(:,1),pose.plan(:,2))
plot(pose.sp(:,1),pose.sp(:,2))
legend('Planned','Set-point');
axis([-1 1 -1 1]);
hold off

% XZ
subplot(3,1,2)
hold on
title('XZ graph')
xlabel('X-axis')
ylabel('Z-axis')
plot(pose.plan(:,1),pose.plan(:,3))
plot(pose.sp(:,1),pose.sp(:,3))
legend('Planned','Set-point');
axis([-1 1 -0.5 2]);
hold off

% YZ
subplot(3,1,3)
hold on
title('YZ graph')
xlabel('Y-axis')
ylabel('Z-axis')
plot(pose.plan(:,2),pose.plan(:,3))
plot(pose.sp(:,2),pose.sp(:,3))
legend('Planned','Set-point');
axis([-1 1 -0.5 2]);
hold off

%% Grafico joint
f3 = figure(3);
set(f3,'OuterPosition',[scrsz(3)/4  50 scrsz(3)/4 (scrsz(4) - 50)]);
clf(f3)

subplot(3,1,1)
plot(t*ones(1,6),q.sp(:,:))
title('Joint positions (set-point)')
xlabel('Time')
ylabel('deg')
% yaxis([-pi/2 pi/2])
legend('q1','q2','q3','q4','q5','q6')

subplot(3,1,2)
plot(t*ones(1,6),q.dot(:,:))
title('Joint velocities (set-point)')
xlabel('Time')
ylabel('deg/s')

subplot(3,1,3)
plot(t,q.man)
title('Manipulability (set-point)')
xlabel('Time')
