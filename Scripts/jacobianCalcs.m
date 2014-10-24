J = p560.jacob0(q);
J = J(1:3,:);
J = J*J'

n = ones(3,1);
n(1) = norm(J(1,:));
n(2) = norm(J(2,:));
n(3) = norm(J(3,:));
n