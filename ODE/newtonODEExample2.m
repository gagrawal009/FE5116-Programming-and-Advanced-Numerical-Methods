% Author: Fabio Cannizzo
%
% newtonODEExample2.m
%
% newtonODEExample2(t0, t1, y0, a, nPower )
%
% t1 : initial time
% t1 : final time
% y0 : initial [space,velocity]
% a : acceleration (scalar)
% nPower : min time step, e.g 5

function newtonODEExample2( t0, t1, y0, a, np )

	% create temporary handle pre-applying the argument a
	tempODE = @(t,y)  newtonODE( t,y, a);

	s = newtonODEExact([t1], y0, a);
	n = 2*10.^[0:1:np];
	r = zeros(np,1);  % allocate memory
	for i=1:1:length(n)
		[ 'iteration: ', num2str(i), ',  nSteps: ', num2str(n(i))],
		[~,y] = euler(tempODE, y0, t0, t1, n(i) );
		r(i) = y(n(i)+1,1);
	end

	loglog(n,abs(r-s))
	xlabel('n Steps')
	ylabel('position error')
    ttl=sprintf('Position Error for Newton ODE with:\na = %d,  pos(0) = %d,  vel(0) = %d', num2str(a), num2str(y0(1)), num2str(y0(2)));
	title(ttl)
