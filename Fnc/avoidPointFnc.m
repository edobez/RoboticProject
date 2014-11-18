function Tout = avoidPoint(T,Tprev,point,radius)
%
    minDelta = 0.01;
    
    % Check for input coherence
    assert(ishomog(T),'T must be homogeneous matrix');
    assert(ishomog(Tprev),'Tprev must be homogeneous matrix');
    assert(isvec(point),'point must be a 3-vector');
    assert(radius > 0,'radius must be strictly positive');
    
    if isrow(point)
        point = point';
    end
    
    % Hom. transformation from 0 to 1 (circle center) and inverse
    T0_1 = transl(point); 
    T1_0 = inv(T0_1);
    
    % Cartesian pose in reference 0 (world) and 1 (circle center)
    p0 = transl(T);
    p1 = T1_0*[p0;1];
    p1 = p1(1:3);    
    
    % Cartesian past pose in reference 0 (world) and 1
    p0prev = transl(Tprev); 
    p1prev = T1_0*[p0prev;1];
    p1prev = p1prev(1:3);
    
    % Distance from point to circle center
    pointDistance = norm(p1(1:2));
    
    % If the point is not inside the XY-plane circle, return
    if pointDistance >= radius
        Tout = T;
        return;
    end
    
    % Slope of line between current and previous pose
    deltax = p1(1) - p1prev(1);
    deltay = p1(2) - p1prev(2);
    
    theta = atan2(deltay,deltax);
    R = trotz(theta);
    T1_2 = R; % Hom. transformation from 1 to 2 (traj. line parallel to x-axis)
    T2_1 = inv(T1_2);
    
    p2 = T2_1*[p1;1];
    p2 = p2(1:3);
    
    % Compute point on the circle
    c2 = p2;
    if abs(p2(2)) < (minDelta + eps)
       p2(2) = 2*minDelta; 
    end
    c2(2) = sqrt(radius^2 - p2(1)^2);
    if p2(2) < 0
        c2(2) = - c2(2);
    end
    
    % Go back to world reference
    c0 = T0_1*T1_2*[c2;1];
    c0 = c0(1:3);
    
    % Make new pose
    Ttemp = T;
    Ttemp(1:3,4) = c0;
    Tout = Ttemp;
    
end