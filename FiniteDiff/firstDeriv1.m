% firstDeriv1
%
% Author: Fabio Cannizzo
%
% Numerically evaluate the derivative of the function handle f using
% right differences with an increment of size ranging from hMin
% to hMax.
% Compare the value with the analytical one computed via the function handle fp
% and plot the errors in logarithmc scale.

function firstDeriv1( f, fp, fname, x, hMin, hMax )
	y  = f(x);
	hs = logspace(hMin, hMax, 500);
	xp = x+hs; hss = xp-x;

	rx = (f(xp)-y)./hss;                     % right estimator
	yp = fp(x) * ones(1, length(hs));  % analytical value (turned into a vector)

	loglog( hs, abs(rx-yp) )
	xlabel('h')
	ylabel('error')
	title(['Error for derivative of ', fname, ' in x=', num2str(x) ])
    axis([hs(1),hs(end),-inf,inf])
end
