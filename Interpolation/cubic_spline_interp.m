function [value_at_x, spline_coeffs] = cubic_spline_interp(x, y, x_req)
    % Inputs:
    %   x       - Vector of x-values (must be sorted in increasing order)
    %   y       - Corresponding y-values
    %   x_req   - Query point where interpolation is required
    %
    % Outputs:
    %   value_at_x     - Interpolated value at x_req using cubic spline
    %   spline_coeffs  - Coefficients of spline segments [a0, a1, a2, a3] for each interval

    % Construct cubic spline piecewise polynomial
    %pp = spline(x, y);
    pp = csape(x, y, 'second');  % Piecewise cubic spline with natural boundary

    % Evaluate spline at requested x
    value_at_x = ppval(pp, x_req);

    % Extract coefficients of each spline segment: [a3 a2 a1 a0]
    % Convert to [a0 a1 a2 a3] for easier understanding (ascending powers of x)
    spline_coeffs = fliplr(pp.coefs);  % Each row corresponds to a segment

    % Optional: display the spline segments
    fprintf('Cubic spline segments (in form y = a0 + a1*(x-xi) + a2*(x-xi)^2 + a3*(x-xi)^3):\n');
    for i = 1:size(spline_coeffs, 1)
        fprintf('Interval [%g, %g]: a0 = %.4f, a1 = %.4f, a2 = %.4f, a3 = %.4f\n', ...
            pp.breaks(i), pp.breaks(i+1), ...
            spline_coeffs(i,1), spline_coeffs(i,2), spline_coeffs(i,3), spline_coeffs(i,4));
    end
end
