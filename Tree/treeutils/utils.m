
function utils
	[a, b] = parametersGBM( 0.01, 0.01, 0.1, 1.2, 100 );
	fprintf( 'parametersGBM : %f, %f\n', a, b );
	[a, b, c, d] = parametersTrinomGBM( 0.01, 0.01, 0.1, 1.2, 100 );
	fprintf( 'parametersTrinomGBM : %f, %f, %f, %f\n', a, b, c, d );
	[ d, u, p ] = parametersBinomGBMCRR( 0.01, 0.01, 0.1, 1.2, 100 );
	fprintf( 'parametersBinomCRR : %f, %f, %f\n', d, u, p );
	[a, b, c] = parametersBinomGBMEqProb( 0.01, 0.01, 0.1, 1.2, 1.3 );
	fprintf( 'parametersBinomGBMEqProb:  %f, %f, %f\n', a, b, c);













