function T = findCirclePt(T,center,radius,delta)
% FINDCIRCLEPT Find closest point on a circle from a given pose.
% T = findCirclePt(T,center,radius,delta) 

    [R,t] = tr2rt(T);
    center = center';
    p = t(1:2);
    v = p - center; % Vector directed from center to point
    
    % Set minimum distance from center
    for i=1:2
        if v(i) >= center(i)
            v(i) = max(v(i),center(i) + delta);
        else 
            v(i) = min(v(i),center(i) - delta);
        end
    end
    
    % Calc vector directed from center to point in the circle
    a = center + v/norm(v)*radius;
    a(3) = t(3);

    T = rt2tr(R,a);
    
end