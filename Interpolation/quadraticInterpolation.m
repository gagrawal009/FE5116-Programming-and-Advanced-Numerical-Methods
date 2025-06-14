function quadraticInterpolation(X, Y)

    % Solve for [a; b; c]
    coeffs = vander(X) \ Y;
    a = coeffs(1);
    b = coeffs(2);
    c = coeffs(3);

    % Display the polynomial
    fprintf('The quadratic polynomial is: P(x) = %.3fx^2 + %.3fx + %.3f\n', a, b, c);

    % Interpolation at x = 0.5
    x_interp = 0.5;
    y_interp = a*x_interp^2 + b*x_interp + c;
    fprintf('Interpolated value at x = %.1f is: %.4f\n', x_interp, y_interp);
end
