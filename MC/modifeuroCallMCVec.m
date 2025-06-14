function [res, stdErr] = modifeuroCallMCVec( rf, yield, vol, T, spot, strike, nSim )
    % generate gaussian random numbers
    % seed random number generator with an arbitrary seed
    % use Mersenne Twister
    rng(1347,'twister');
    %rnds = randn( nSim, 1 );
    % for efficiency generate all random number upfront
    rnds = [0.98,-0.11,-0.57,0.85];

    logStdDev = vol * sqrt( T );
    factor = spot * exp( ( (rf-yield) - 0.5 * vol * vol ) * T );
    k = strike / factor;

    % vectorial operations
    s = exp( logStdDev * rnds);
    payoff = exp( -rf * T ) * factor * max( s - k, 0.0 );
    res = mean(payoff);

    stdErr = sqrt(var(payoff) / nSim);
end