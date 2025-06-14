function [y, coeffs] = interpolatePoly(X, Y, x)
    % Ensure X and Y are column vectors
    if isrow(X)
        X = X';
    end
    if isrow(Y)
        Y = Y';
    end
    
    % Solve for polynomial coefficients
    coeffs = vander(X) \ Y;
    
    % Evaluate the polynomial at the given x
    y = polyval(coeffs, x);
end
