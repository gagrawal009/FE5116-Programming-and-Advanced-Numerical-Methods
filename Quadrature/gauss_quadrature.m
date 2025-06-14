function result = gauss_quadrature(f, xi, Ai)
    % GAUSS_QUADRATURE Numerically approximates integrals using given quadrature rule
    %
    % Inputs:
    %   f - Function to integrate (e.g., @(x) cos(x))
    %   weight_func - Weight function (e.g., @(x) exp(-x.^2))
    %   xi - Vector of quadrature nodes (abscissas)
    %   Ai - Vector of quadrature weights
    %
    % Output:
    %   result - Approximated integral value
    
    % Validate inputs
    if nargin ~= 3
        error('Usage: gauss_quadrature(f, weight_func, xi, Ai)');
    end
    if length(xi) ~= length(Ai)
        error('Nodes (xi) and weights (Ai) must have same length');
    end
    
    % Compute weighted sum: sum(Ai * f(xi) / weight_func(xi))
    % Note: For Gauss-Hermite, weight_func = exp(-x.^2) is already factored into Ai
    result = sum(Ai .* f(xi));
end