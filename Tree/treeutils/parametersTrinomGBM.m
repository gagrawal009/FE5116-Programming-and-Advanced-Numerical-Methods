% use extra conditions pm=1/3, m=1, u=1/d
function [d, m, u, pu, pm] = parametersTrinomGBM( rf, yield, vol, T, N )

	[x1, x2] = parametersGBM( rf, yield, vol, T, N );
	pm = 1.0 / 3.0;
	x2p = x2 + pm;
	x1m = x1 - pm;
	d = ( x2p - sqrt( x2p * x2p - 4.0 * x1m * x1m ) ) / ( 2.0 * x1m );
	u = 1.0 / d;
	pu = ( x1m - 2.0 * d / 3.0 ) / ( u - d );
	m = 1.0;
end

