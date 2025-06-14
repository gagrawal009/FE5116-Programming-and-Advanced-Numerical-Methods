function [ d, u, p ] = parametersBinomGBMNextPeriod( rf, yield, vol, T, udRatio )

	[x1, x2] = parametersGBM( rf, yield, vol, T, 1.0 );
	b = ( 1.0 + udRatio ) * x1;
	d = ( b - sqrt( b * b - 4.0 * udRatio * x2 ) ) / ( 2.0 * udRatio );
	u = udRatio * d;
	p = ( x1 - d ) / ( u - d );
end

