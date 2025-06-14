function [x, u] = trivial_prng(a, b, x0, n)
% TRIVIAL_PRNG Generates a pseudo-random sequence using a linear congruential generator (LCG)
% Inputs:
%   a  - multiplier
%   b  - modulus
%   x0 - seed (initial value)
%   n  - number of values to generate
% Outputs:
%   x  - raw sequence of integers
%   u  - normalized sequence in (0, 1)

    x = zeros(1, n);
    u = zeros(1, n);

    x(1) = x0;
    u(1) = x(1) / b;

    for i = 2:n
        x(i) = mod(a * x(i-1), b);
        u(i) = x(i) / b;
    end
end
