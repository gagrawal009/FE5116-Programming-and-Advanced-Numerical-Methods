% Author: Fabio Cannizzo
%
% newtonODEExample1.m
%
% newtonODEExample1(t0, t1, y0, a, n )
%
% t1 : initial time
% t1 : final time
% y0 : initial [space,velocity]
% a : acceleration (scalar)
% n  : number of intervals e.g. [2,3,4]

function newtonODEExample1( t0, t1, y0, a, n )

	t = t0:(t1-t0)/100:t1;
	s = newtonODEExact(t, y0, a);

	% create temporary handle pre-applying the argument a
	tempODE = @(t,y)  newtonODE( t,y, a);

	plot(t,s)
	xlabel('time')
	ylabel('position error')
    ttl=sprintf('Position Error for Newton ODE with:\na = %d,  pos(0) = %d,  vel(0) = %d', num2str(a), num2str(y0(1)), num2str(y0(2)));
	title(ttl)
	hold all

	l = cell(length(n)+1,1);
	l{1} = 'analytic';

	hold on
	for i=1:1:length(n)
		[ts,y] = euler(tempODE, y0, t0, t1, n(i) );
		plot( ts, y(:,1) )
		l{i+1} = [ 'euler with ', num2str(n(i)), ' steps' ];
	end
	hold off
	legend(l, 'location', 'west')

	hold off



