% Author: Fabio Cannizzo
%
% r = newtonODEExact(t, y0, a )
%
% t : times (vector)
% y0 : initial [space,velocity]
% a : acceleration (scalar)

function space = newtonODEExact( t, y0, a )
	space = y0(1) + y0(2)*t + (0.5*a)*t.*t;


