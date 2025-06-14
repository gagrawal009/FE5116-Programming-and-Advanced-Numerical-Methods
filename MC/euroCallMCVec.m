        function [res, stdErr] = euroCallMCVec( rf, yield, vol, T, spot, strike, nSim )
    % generate gaussian random numbers
    % seed random number generator with an arbitrary seed
    % use Mersenne Twister
    rng(1347,'twister');
    % for efficiency generate all random number upfront
    %rnds = randn( nSim, 1 );
    rnds = [0.98,-0.11,-0.57,0.85];
    %rnds =[0.5377, 1.8339, -2.2588, 0.8622, 0.3188];

    logStdDev = vol * sqrt( T );
    factor = spot * exp( ( (rf-yield) - 0.5 * vol * vol ) * T );
    k = strike / factor;

    % vectorial operations
    s = exp( logStdDev * rnds);
    %payoff = exp( -rf * T ) * factor * max( s - k, 0.0 ); %call
    payoff = exp( -rf * T ) * factor * max( k - s, 0.0 ); %put
    res = mean(payoff);

    stdErr = sqrt(var(payoff) / nSim);
end
