% newtonODE
%
% Author: Fabio Cannizzo
%
% r = newtonODE (t, y, g)
%
% t : time
% y : vector of size 2 [space,velocity]
% g : acceleration (scalar)
% r : derivative of space and velocity
%

function res = newtonODE( t, y, g )
	res = [ y(2), g ];


