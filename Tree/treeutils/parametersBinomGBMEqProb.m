function [ d, u, p ] = parametersBinomGBMEqProb( rf, yield, vol, T, N )

	[x1, x2] = parametersGBM( rf, yield, vol, T, N );
	h = sqrt( x2 - x1 * x1 );
	d = x1 - h;
	u = x1 + h;
	p = 0.5;
end

