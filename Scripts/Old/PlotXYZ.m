Nmax = size(T,3) - 1;
t = 1:1:Nmax;
posT = transl(T);
posTref = transl(Tref);
posTref2 = transl(Tref2);

% Graph plot with desidered pose and measured pose of TPC
figure(1);
for i=1:3    
    subplot(3,1,i);
    plot(t,posTref(1:Nmax,i),t,posT(1:Nmax,i));
    legend('Reference','Output');
end

% Graph XY plots
figure(2);
plot(posTref(:,1),posTref(:,2), ...
    posTref2(:,1),posTref2(:,2), ...
    posT(:,1),posT(:,2) ...
    );
axis([-1 1 -1 1]);
title('XY plot');
legend('Reference','Ref.2','Output');

% Graph manipulability
figure(3);
m = p560.maniplty(q);
plot(m);
title('Manipulability (Yoshikawa)');