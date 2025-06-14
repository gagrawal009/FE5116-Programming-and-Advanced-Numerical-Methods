function val = americanBinomialVec( d, u, p, T, N, rf, spot, payoff )

	ratioUD = u / d;
	df = exp( -rf * T / N );
	q = 1.0 - p;

	v = zeros( N + 1 );

	lastLowest = spot * d ^ N;
	prices = lastLowest * ((ratioUD * ones( N + 1, 1 )) .^ (0 : N)');
	
	v = payoff(prices);

	for tS = N:-1:1
		prices = prices( 1:tS ) ./ d;
		v = max( payoff(prices), df .* ( p .* v( 2:tS+1 ) + q .* v( 1:tS ) ) );
	end

	val = v( 1 );


