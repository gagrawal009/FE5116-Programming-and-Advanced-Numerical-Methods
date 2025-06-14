% Monte Carlo with antitethic variates and computation of
% antithetic standard error
function [res, stdErr] = euroCallMCVecStratified( rf, yield, vol, T, spot, strike, nSim )

    % seed generator with an arbitrary seed and use Mersenne Twister
    rng(1347,'twister');

    % generate uniform random number upfront
    urnds = rand( nSim, 1 );

    % usefule constants
    logStdDev = vol * sqrt( T );
    drift = ((rf-yield) - 0.5 * vol * vol ) * T ;
    df = exp(-rf*T);

    % find uniform random number corresponding to strike
    u = normcdf((log(strike / spot) - drift) / logStdDev);
    % define strata: 0 paths in [0,u],  with strata prob u
    %                nSim paths in [u,1],  with strata prob 1 - u
    prob = 1 - u;
    urnds = min(urnds * (1-u) + u, 1);  % we take min to avoid numerical issues
    % compute gaussian numbers
    rnds = norminv(urnds);
    hist(rnds,20)

    % vectorial operations
    s = spot * exp(drift) * exp( logStdDev * rnds);
    payoff = df * max( s - strike, 0.0 );

    % aggregate results
    res = mean(payoff) * prob;
    % note the different formula standard deviation, because we must keep
    % track of the strata
    stdErr = prob * sqrt(var(payoff) / nSim);
end