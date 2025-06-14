% @americanBinomTest@ plots the value in the binomial tree of the american put option option in Black-Scholes model against
% the value of the same put, european style, computed analytically
function americanBinomTest( spot, strike, rf, vol, T, N )

	yield = 0.0;
    binom1 = zeros(N,1);  % preallocate for speed
    binom2 = zeros(N,1);  % preallocate for speed
    payoff = @(s)putPayoff(s,strike);
	for i= 1:N
		[ d, u, p ] = parametersBinomGBMEqProb( rf, 0.0, vol, T, i );
		binom1(i) = americanBinomialVec( d, u, p, T, i, rf, spot, payoff );
		[ d, u, p ] = parametersBinomGBMCRR( rf, 0.0, vol, T, i );
		binom2(i) = americanBinomialVec( d, u, p, T, i, rf, spot, payoff );
	end
    fwd = spot * exp( ( rf - yield ) * T );
    df = exp( -rf * T );
	blk = df * black( fwd, strike, vol, T, false );

	plot( (1:N)', [ binom1-blk, binom2-blk ] );



