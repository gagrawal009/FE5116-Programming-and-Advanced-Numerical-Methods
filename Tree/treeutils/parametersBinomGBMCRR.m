function [ d, u, p ] = parametersBinomGBMCRR( rf, yield, vol, T, N )
	[x1, x2] = parametersGBM( rf, yield, vol, T, N );
	d = ( ( 1.0 + x2 ) - sqrt( ( 1.0 + x2) * ( 1.0 + x2 ) - 4.0 * x1 * x1 ) ) / ( 2.0 * x1 );
	u = 1.0 / d;
	p = ( x1 - d ) / ( u - d );
end
