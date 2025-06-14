function res = asianCall( rf, yield, vol, T, spot, strike, nSteps, nSim )

	dt = T / nSteps;
	nFixings = nSteps + 1;
	logDrift = ( (rf-yield) - 0.5 * vol * vol ) * dt;
	logStdDev = vol * sqrt( dt );

    % seed random number generator with an arbitrary seed
    % use Mersenne Twister
    rng(1347,'twister');
	rnds = randn( nSim, nSteps ); % generate Gaussian numbers

	priceSum= 0.0;
	for i = 1:nSim %loop on simulations
		pathSum = spot;
		s = spot;
		for step = 1:nSteps % loop on time steps
			s = s * exp( logDrift + rnds( i, step ) * logStdDev );
			pathSum = pathSum + s;
		end
		avg = pathSum / nFixings; % compute average
		payoff = max( avg - strike, 0.0 );
		priceSum = priceSum + payoff;
	end

	res = exp( -rf * T ) * priceSum / nSim;
