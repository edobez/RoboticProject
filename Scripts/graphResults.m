close all

%% Acquisizione dati da output modello
pose.sp = transl(out.get('Tsp'));
pose.plan = transl(out.get('Tplan'));

q.sp = out.get('q');
q.dot = out.get('qdot');

t = out.get('tout');

%% Grafico proiezioni traiettorie
scrsz = get(groot,'ScreenSize');
figure('OuterPosition',[1 50 scrsz(3)/4 (scrsz(4) - 50)])

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
axis([-1 1 -1 1]);
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
axis([-1 1 -1 1]);
hold off

%% Grafico joint
figure(2)
subplot(2,1,1)
plot(t(2:end-1)*ones(1,6),q.sp(:,:))
title('Joint positions (set-point)')
xlabel('Time')
ylabel('Rad')
yaxis([-pi pi])
legend('q1','q2','q3','q4','q5','q6')

subplot(2,1,2)
plot(t*ones(1,6),q.dot(:,:))
title('Joint velocities (set-point)')
xlabel('Time')
ylabel('Rad/s')
