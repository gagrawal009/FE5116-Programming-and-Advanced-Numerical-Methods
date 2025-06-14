function z=mydefault(x,y)
	assert(nargin > 0, 'at least one argument is necessary');
    if (nargin==1)
        % assign a default value to y
        y = 2;
    end

    z = x+y;

