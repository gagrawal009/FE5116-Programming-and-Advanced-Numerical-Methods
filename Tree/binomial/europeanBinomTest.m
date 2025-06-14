
% @europeanBinomTest@ plots the analytic value of the call option in Black-Scholes model against
% the value of the same call computed using the binomial tree
function binom = europeanBinomTest( spot, strike, rf, yield, vol, T, N )

	% init with the right size to avood memory reallocation every time a new element is appended
	binom = zeros(N,2);

	% price on tree
    payoff=@(S) callPayoff( S, strike );
	for i= 1:N
		[ d, u, q ] = parametersBinomGBMEqProb( rf, yield, vol, T, i );
		binom(i,1) = europeanBinomialPricer( d, u, q, T, i, rf, spot, payoff );
        binom(i,2) = europeanBinomialPricerRobust( d, u, q, T, i, rf, spot, payoff );
	end

	% analytic price
	fwd = spot * exp( ( rf - yield ) * T );
	discountFactor = exp(-rf * T);
	analytic = discountFactor * black(fwd, strike, vol, T, true);

	%plot
	plot( [1:N]', [ ones(N,1)*analytic, binom ] );
end








