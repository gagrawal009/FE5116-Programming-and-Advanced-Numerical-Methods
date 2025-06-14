function p = black( f, k, sigma, t, call )
% return the price of an undiscounted call or put price
% f: forward price
% k: strike
% sigma: volatility
% t: time to expiry
% call: boolean (true means Call, false measn Put)

	stdev = sigma * sqrt( t );
	d1 = log( f / k ) / stdev  + 0.5 * stdev;
	d2 = d1 - stdev;
	p = f * normcdf( d1 ) - k * normcdf( d2 );

	if ( ~call )
		p = p - ( f - k )
	end


