function res = callPayoff( spotPrice, strike )

	res = max( spotPrice - strike, 0.0 );


