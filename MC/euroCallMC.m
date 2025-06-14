function [res, stderr] = euroCallMC( rf, yield, vol, T, spot, strike, nSim )

	% choose to use Mersenne Twister
    % and seed random number generator to 1347 (arbitrary choice)
    rng(1347,'twister');  % replace the old syntax randn('state',1347)
    % generate gaussian random numbers
    % for efficiency generate all random number upfront
	rnds = randn( nSim, 1 );

	logStdDev = vol * sqrt( T );
	factor = spot * exp( ( (rf-yield) - 0.5 * vol * vol ) * T );
	k = strike / factor;
    df = exp( -rf * T );

	price = 0; % loop accumulation variable
    pricesqr = 0;
	for i = 1:nSim
		s = exp( logStdDev * rnds( i ) );
		payoff = max( s - k, 0.0 );
		price = price + payoff;
        pricesqr = pricesqr + payoff * payoff;
    end

    avg = price / nSim;        % E[payoff]
    avgsqr = pricesqr / nSim;  % E[payoff^2]
	res = df * factor * avg;

    variance = avgsqr - avg*avg  % E[payoff^2] - E[payoff]^2
    stderr = df * factor * sqrt(variance / nSim);
end