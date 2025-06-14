function res = putPayoff( spotPrice, strike )

	res = max( strike - spotPrice, 0.0 );


