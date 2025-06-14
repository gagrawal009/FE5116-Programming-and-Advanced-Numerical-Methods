% @crr_vs_jr@ plots the analytic value of the call option in Black-Scholes model against
% the value of the same call computed using the binomial tree with CRR and JR
function crr_vs_jr( spot, strike, rf, yield, vol, T, N )

	% init with the right size to avood memory reallocation every time a new element is appended
	prices = zeros(N,2);

	% price on tree
    payoff=@(S) callPayoff( S, strike );
	for i= 1:N
        [ d1, u1, q1 ] = parametersBinomGBMCRR( rf, yield, vol, T, i );
		[ d2, u2, q2 ] = parametersBinomGBMEqProb( rf, yield, vol, T, i );

		prices(i,1) = europeanBinomialPricer( d1, u1, q1, T, i, rf, spot, payoff );
        prices(i,2) = europeanBinomialPricer( d2, u2, q2, T, i, rf, spot, payoff );
	end

	% analytic price
	fwd = spot * exp( ( rf - yield ) * T );
	discountFactor = exp(-rf * T);
	analytic = discountFactor * black(fwd, strike, vol, T, true);
    errors=prices - analytic;

	%plot
	plot( (1:N)', errors );
