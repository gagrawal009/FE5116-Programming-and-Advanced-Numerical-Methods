function [x_nodes, y_nodes, m] = linearSplineCoefs(f, x_nodes)
% linearSplineCoefs - Computes slopes (m_i) for linear spline interpolation
%
% Inputs:
%   f        - Function handle, e.g., @(x) sin(x).^2
%   x_nodes  - Vector of x-values (must be increasing and evenly spaced is ideal)
%
% Outputs:
%   x_nodes  - Same as input (returned for clarity)
%   y_nodes  - Function values at x_nodes, i.e., y_i = f(x_i)
%   m        - Slopes of linear spline segments between x_nodes

    y_nodes = f(x_nodes);           % Compute function values at given nodes
    m = diff(y_nodes) ./ diff(x_nodes);  % Compute slopes m_i = (y_{i+1} - y_i)/(x_{i+1} - x_i)
end

