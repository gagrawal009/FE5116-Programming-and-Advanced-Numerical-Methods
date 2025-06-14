function result = myExpHornerRule(x)
    % Coefficients of the polynomial: 1 + x + x^2/2 + x^3/6 + x^4/24
    coeffs = [1/24, 1/6, 1/2, 1, 1];  % a4, a3, a2, a1, a0

    % Initialize result with the first coefficient (a4)
    result = coeffs(1);

    % Apply Horner's rule
    for i = 2:length(coeffs)
        result = result * x + coeffs(i);
    end
end