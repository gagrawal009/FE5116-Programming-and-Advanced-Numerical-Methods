% price of an up and out barrier call option
% use antithetic variables
% it is an approximation: we only chechk the barrier at mc time steps
% we need lot of time steps: converge is slow
function res = uoCallVec( rf, yield, vol, T, spot, strike, koBarrier, nSteps, nSim )
    assert(koBarrier > strike, "in an UO Call the KO barrier must be greater than the strike");

    dt = T / nSteps;
    logDrift = ( (rf-yield) - 0.5 * vol * vol ) * dt;
    logStdDev = vol * sqrt( dt );

    % seed random number generator with an arbitrary seed
    % use Mersenne Twister
    rng(1347,'twister');

    s = spot * ones(nSim, 1);
    alive = ones(nSim,1); % true everywhere

    rnds = zeros(nSim,1);
    for step = 1:nSteps % loop on time steps
        rnds(1:nSim/2) = randn( nSim /2, 1); % generate Gaussian numbers
        rnds(nSim/2+1:end) = -rnds(1:nSim/2);  % antithetic
        s = s .* exp( logDrift + rnds * logStdDev);
        alive = alive .* (s < koBarrier);
    end
    payoff = max( s - strike, 0.0 ) .* alive;
    res = exp( -rf * T ) * mean(payoff);
end