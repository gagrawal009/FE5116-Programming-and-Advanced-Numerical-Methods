function val = americanBinomialPricer( d, u, p, T, N, rf, spot, payoff )

	ratioUD = u / d;
	df = exp( -rf * T / N );
	q = 1.0 - p;

	v = zeros( N + 1, 1 );

	price = spot * d ^ N; % price corresponding to state j = 1
	lastLowest = price; % lowest price in this time step

	for j = 1:N+1
		v( j ) = payoff(price);
		price = price * ratioUD;
	end

	for tS = N:-1:1
		lastLowest= lastLowest / d;
		price = lastLowest;
		for j = 1:tS
			v( j )= max( payoff(price), df * ( p * v( j + 1 ) + q * v( j ) ) );
			price = price * ratioUD;
		end
	end

	val = v( 1 );
end
