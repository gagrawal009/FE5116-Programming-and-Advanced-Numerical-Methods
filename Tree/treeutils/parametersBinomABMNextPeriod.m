function [ d, u, p ] = parametersBinomABMNextPeriod( rf, yield, vol, T, duDiff )
    % Get local mean and variance from ABM parameters
    [localMean, localVar] = parametersABM(rf, yield, vol, T, 1.0);

    % Solve for down move (d) using quadratic method
    b = 2.0 * localMean;
    d = ( b - sqrt( b^2 + 4.0 * (localVar - duDiff^2) ) ) / 2.0;

    % Compute up move as d + duDiff
    u = d + duDiff;

    % Compute risk-neutral probability
    p = ( localMean - d ) / ( u - d );
end
