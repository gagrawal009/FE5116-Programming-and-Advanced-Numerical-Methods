% price of an up and out barrier call option
% use antithetic variables
% use a Brownian brdige to assess the probability ot touch
% faster and more accurate than uoCallVec
function res = uoCallBridgeVec( rf, yield, vol, T, spot, strike, koBarrier, nSim )
    assert(koBarrier > strike, "in an UO Call the KO barrier must be greater than the strike");
    
    if (spot >= koBarrier)
        res = 0;
        return;
    end

    logDrift = ( (rf-yield) - 0.5 * vol * vol ) * T;
    logStdDev = vol * sqrt( T );

    % seed random number generator with an arbitrary seed
    % use Mersenne Twister
    rng(1347,'twister');

    S = spot * ones(nSim, 1);

    rnds = zeros(nSim,1);
    rnds(1:nSim/2) = randn( nSim /2, 1); % generate Gaussian numbers
    rnds(nSim/2+1:end) = -rnds(1:nSim/2);  % antithetic
    S = S .* exp( logDrift + rnds * logStdDev);
    probKo = exp(-2*(log(koBarrier/spot) * log(koBarrier ./ S) / (vol*vol*T)));
    payoff = max( S - strike, 0.0 ) .* (1-probKo) .* (S<koBarrier);
    res = exp( -rf * T ) * mean(payoff);
end