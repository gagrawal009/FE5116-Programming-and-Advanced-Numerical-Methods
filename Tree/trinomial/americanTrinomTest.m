% @americanTrinomTest@ plots the value in the trinomial tree of the american put option option in Black-Scholes model against
% the value of the same put, on a binomial tree
function americanTrinomTest( spot, strike, rf, vol, T, N )

	yield = 0.0;
	start = 100;
	arr = (start:start+(N-1))';
    payoff=@(s) putPayoff(s, strike);
    trinom1=zeros(N,1);
    binom1=zeros(N,1);
	for i= start:start+(N-1)
		[ d, m, u, pu, pm ] = parametersTrinomGBM( rf, 0.0, vol, T, i );
		trinom1(i-start+1) = americanTrinomialVec( u, m, d, pm, pu, i, rf, T, spot, payoff );
		[ d, u, p ] = parametersBinomGBMCRR( rf, 0.0, vol, T, i );
		binom1(i-start+1) = americanBinomialVec( d, u, p, T, i, rf, spot, payoff );
	end
	fwd = spot * exp( ( rf - yield ) * T );
    df = exp( -rf * T );
	blk = df * black( fwd, strike, vol, T, false );

	plot( arr, [ trinom1 - blk, binom1 - blk] );


