% Monte Carlo with control variates and computation of standard error
% we use E[S] as a control variate for a call option
function [res, stdErr] = euroCallMCVecCV( rf, yield, vol, T, spot, strike, nSim )
    % seed generator and compute gaussian
    rng(1347,'twister');
    rnds = randn( nSim, 1 );

    % useful constants
    logStdDev = vol * sqrt( T );
    drift = ((rf-yield) - 0.5 * vol * vol ) * T;
    fwd = spot * exp((rf-yield) * T); % E[S] theoretical
    df = exp(-rf*T);  % discount factor

    % vectorial operations
    s = spot .* exp( drift + logStdDev * rnds);
    payoff = max( s - strike, 0.0 );  % call option
    cvpayoff = s;                     % E[S] estimated
    c = cov([payoff, cvpayoff]);      % covariance matrix
    lambda = c(2,1) / c(2,2);         % CV coefficient
    cvadjusted = payoff - lambda * (cvpayoff - fwd); % CV adjustment

    % aggregate results
    res = df * mean(cvadjusted);
    stdErr = df * sqrt(var(cvadjusted) / nSim);
end