% firstDeriv2
%
% Author: Fabio Cannizzo
%
% Numerically evaluate the derivative of the function handle f using left,
% central and right differences with an increment of size ranging from hMin
% to hMax.
% Compare the value with the analytical one computed via the function handle fp
% and plot the errors in logarithmc scale.

function firstDeriv2 ( f, fp,fname, x, hMin, hMax )
	y  = f(x);  % exact value (note the semicolon at the end)

	% h vector: equally spaced points in log space
	hs = logspace(hMin, hMax, 500);
	lx = derivRatio( f, x, hs, -1,   0   );           % left estimator
	rx = derivRatio( f, x, hs,  0,   1   );           % right estimator
	cx = derivRatio( f, x, hs, -0.5, 0.5 );           % central estimator
	yp = fp(x) * ones(1,length(hs));              % exact value

	% plot errors in log space
	loglog( hs, abs(rx-yp), hs, abs(cx-yp), hs, abs(lx-yp) )
	axis([hs(1),hs(end),-inf,inf])
    xlabel('h')
	ylabel('error')
	title(['Error for derivative of ', fname, ' in x=', num2str(x) ])
	legend( 'right', 'central', 'left', 'location', 'south', 'orientation', 'horizontal')
end


