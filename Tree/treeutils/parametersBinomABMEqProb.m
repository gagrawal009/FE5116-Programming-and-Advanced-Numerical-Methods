function [d, u, p] = parametersBinomABMEqProb(rf, yield, vol, T, N)
    % Get mean and variance from ABM parameters
    [localMean, localVar] = parametersABM(rf, yield, vol, T, N);
    
    % Calculate standard deviation
    h = sqrt(localVar);  
    
    % Compute up and down moves
    d = localMean - h;   % μ - σ√Δt
    u = localMean + h;   % μ + σ√Δt
    p = 0.5;             % Equal probability
    
    % Verification (should match ABM moments)
    calculated_mean = p*u + (1-p)*d;
    calculated_var = p*(1-p)*(u-d)^2;
    
    assert(abs(calculated_mean - localMean) < 1e-10, 'Mean mismatch');
    assert(abs(calculated_var - localVar) < 1e-5, 'Variance mismatch');
end