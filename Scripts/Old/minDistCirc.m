function T = minDistCirc(T,r)
    pos = transl(T);
    
    x = sqrt((r^2*pos(1)^2)/(pos(1)^2+pos(2)^2));
    if pos(1) < 0
        x = -x;
    end
    
    y = sqrt(r^2-x^2);
    if pos(2) < 0
        y = -y;
    end
    
    T = transl(x,y,pos(3));
    
end