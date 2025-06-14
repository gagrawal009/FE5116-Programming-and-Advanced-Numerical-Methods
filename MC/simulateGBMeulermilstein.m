function S = simulateGBMeulermilstein(method, S0, mu, sigma, T, N, epsilon)
% SIMULATEGBM Simulates GBM paths using Exact, Euler, or Milstein method.
% Inputs:
%   method: 'exact', 'euler', or 'milstein'
%   S0: Initial asset price
%   mu: Risk-free drift rate (annualized)
%   sigma: Volatility (annualized)
%   T: Total time period (years)
%   N: Number of time steps
%   epsilon: Vector of N(0,1) random numbers (length N)
% Output:
%   S: Simulated path (vector of size N+1)

dt = T / N;  % Time step size
S = zeros(N+1, 1);  % Initialize path
S(1) = S0;  % Set initial price

for t = 1:N
    switch lower(method)
        case 'exact'
            % Exact solution (closed-form)
            S(t+1) = S(t) * exp((mu - 0.5*sigma^2)*dt + sigma*sqrt(dt)*epsilon(t));
            
        case 'euler'
            % Euler-Maruyama discretization
            S(t+1) = S(t) * (1 + mu*dt + sigma*sqrt(dt)*epsilon(t));
            
        case 'milstein'
            % Milstein scheme (higher-order correction)
            S(t+1) = S(t) * (1 + mu*dt + sigma*sqrt(dt)*epsilon(t) + ...
                      0.5*sigma^2*dt*(epsilon(t)^2 - 1));
            
        otherwise
            error('Invalid method. Use "exact", "euler", or "milstein".');
    end
end
end