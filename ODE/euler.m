    % Author: Fabio Cannizzo
%
% euler.m
%
% res = euler (ode, ys, xs, xe, n )
%
% ode  : system of ODEs y1=ode(x0,y0) (vectorial function)
% ys   : initial condition (vector)
% xs   : initial x (scalar)
% xe   : last x (scalar)
% n    : number of intervals

function [x,y] = euler( ode, ys, xs, xe, n )
	h  = (xe-xs)/n;                 % integration step
	x  = xs + [0:1:n]*h;            % independent variable at integration points
	y = zeros( n+1, length(ys) );   % pre-allocate memory for the solution
	y(1,:) = ys;                    % initialize solution at initial point x=xs
	for j=1:1:n,
		y(j+1,:) = y(j,:) + ode( x(j), y(j,:) )*h;  % integration step
	end



