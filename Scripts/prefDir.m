function v = prefDir(robot,q)
    J = robot.jacob0(q);
    J = J(1:3,:);
    Js = J*J';
    
    N = sqrt(sum(abs(Js).^2,2));
    [C,i] = max(N);
    
    v = Js(i,:);
    
end