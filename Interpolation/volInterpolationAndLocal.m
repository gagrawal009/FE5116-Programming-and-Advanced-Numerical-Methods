function [sigma_interp, sigma_01, sigma_12] = volInterpolationAndLocal(T1, T2, sigma1, sigma2, T)
    % Inputs:
    %   T1, T2     - Two known maturities (in years)
    %   sigma1     - Implied volatility at T1
    %   sigma2     - Implied volatility at T2
    %   T          - Target maturity (must be in [T1, T2])
    %
    % Outputs:
    %   sigma_interp - Interpolated implied volatility at T (linear in variance)
    %   sigma_01     - Piecewise constant volatility on [0, T1]
    %   sigma_12     - Piecewise constant volatility on (T1, T2]

    % Sanity check
    if T < T1 || T > T2
        error('T must be between T1 and T2.');
    end

    totalVar_T2 = sigma2^2 * T2;
    totalVar_T1 = sigma1^2 * T1;

    % Question 3: Linear interpolation in variance
    var_interp = totalVar_T1 * (T2 - T)/(T2 - T1) + totalVar_T2 * (T - T1)/(T2 - T1);
    sigma_interp = sqrt(var_interp/T);

    % Question 4: Piecewise constant volatility
    sigma_01 = sigma1;
    sigma_12_sq = (totalVar_T2 - totalVar_T1) / (T2 - T1);
    sigma_12 = sqrt(sigma_12_sq);

    % Display results
    fprintf('Question 3: Interpolated implied volatility at T=%.4f is %.4f (%.2f%%)\n', ...
        T, sigma_interp, sigma_interp*100);
    fprintf('Question 4: sigma_01 = %.4f (%.2f%%), sigma_12 = %.4f (%.2f%%)\n', ...
        sigma_01, sigma_01*100, sigma_12, sigma_12*100);
end