function z=mygcd(x,y)
    assert(x ~= 0 || y ~=0, 'at least one of the two arguments must be different from zero')
    assert(x == uint64(x), 'x must be a positive integer')
    assert(y == uint64(y), 'y must be a positive integer')
    
    % sort x and y
    if (x < y),
        t=x;
        x=y;
        y=t;
    end    
    
    z = mygcd2(x,y);
end

function z = mygcd2(x,y)
    if (y==0)
        z = x;
    else
        z = mygcd2(y, mod(x,y));
    end
end
    
    