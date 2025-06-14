% firstDeriv4
%
% Author: Fabio Cannizzo
%
% Numerically evaluate the derivative of the function handle f using left,
% central and right differences with an increment of size ranging from hMin
% to hMax.
% Compare the value with the analytical one computed via the function handle fp
% and plot the errors in logarithmc scale.

function firstDeriv4 ( f, fp, fname, x, hMin, hMax )
	y  = f(x);  % exact value (note the semicolon at the end)

	% h vector: equally spaced points in log space
	hs = logspace(hMin, hMax, 500);
	lx = derivRatio( f, x, hs, -1,   0   );           % left estimator
	rx = derivRatio( f, x, hs,  0,   1   );           % right estimator
	cx = derivRatio( f, x, hs, -0.5, 0.5 );           % central estimator

	rd =  4/3*cx - derivRatio( f, x, hs, -1, 1 ) / 3; % richardson
	rd2 =  0.1 * derivRatio( f, x, hs, -1, 1 ) -0.6 * derivRatio( f, x, hs, -2/3, 2/3 ) +1.5 * derivRatio( f, x, hs, -1/3, 1/3 );     % richardson with 6 points
	yp = fp(x) * ones(size(hs));                   % exact value

	% plot errors in log space
	loglog( hs, abs(rx-yp), hs, abs(cx-yp), hs, abs(lx-yp), hs, abs(rd-yp), hs, abs(rd2-yp))
	axis([hs(1),hs(end),-inf,inf])
    xlabel('h')
	ylabel('error')
	title(['Error for derivative of ', fname, ' in x=', num2str(x) ])
	legend( 'right', 'central', 'left', 'richardson', 'richardson2', 'location', 'west')
end

