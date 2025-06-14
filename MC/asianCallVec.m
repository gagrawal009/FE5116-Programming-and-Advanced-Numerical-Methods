function res = asianCallVec( rf, yield, vol, T, spot, strike, nSteps, nSim )

	dt = T / nSteps;
	nFixings = nSteps + 1;
	logDrift = ( (rf-yield) - 0.5 * vol * vol ) * dt;
	logStdDev = vol * sqrt( dt );

    % seed random number generator with an arbitrary seed
    % use Mersenne Twister
    rng(1347,'twister');
	rnds = randn( nSim, nSteps ); % generate Gaussian numbers

	s = spot * ones(nSim, 1); % init spot
    pathSum = s;
	for step = 1:nSteps % loop on time steps
		s = s .* exp( logDrift + rnds( :, step ) * logStdDev );
		pathSum = pathSum + s;
	end

	avg = pathSum / nFixings; % compute average
	payoff = max( avg - strike, 0.0 );

	res = exp( -rf * T ) * mean(payoff);
end