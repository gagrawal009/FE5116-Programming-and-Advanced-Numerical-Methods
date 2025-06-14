% Monte Carlo with antitethic variates and computation of
% antithetic standard error
function [res, stdErr] = euroCallMCVecAnti( rf, yield, vol, T, spot, strike, nSim )

    % seed generator with an arbitrary seed and use Mersenne Twister
    rng(1347,'twister');

    % nSim must be even
    if (mod(nSim,2)), nSim = nSim +1; end
    nHalf = nSim / 2;

    % for efficiency generate all gaussian random number upfront
    rnds = randn( nHalf, 1 );
    rnds = [rnds; -rnds];  % the 2nd half are antithetic of 1st half

    logStdDev = vol * sqrt( T );
    factor = spot * exp( ( (rf-yield) - 0.5 * vol * vol ) * T );
    k = strike / factor;

    % vectorial operations
    s = exp( logStdDev * rnds);
    payoff = max( s - k, 0.0 );
    pv = exp( -rf * T ) * factor * payoff;

    % aggregate results
    res = mean(pv);
    % note the different formula standard deviation, because we must keep
    % into account that we are using antitetic, hence the random numbers
    % are not all independent (i.i.d). However, pairs of random numbers
    % and the correspondent antithetic are independent (i.i.d)
    antipvs = (pv(1:nHalf) + pv(1+nHalf:end)) / 2; % aggregate antithetic pairs
    variance = var(antipvs);
    stdErr = sqrt(variance / nHalf); % we have nHalf antitethic samples
end