function [value_at_x, coeffs] = interpolationspline_with_coeffs(x, y, xi, method)
    % Inputs:
    %   x, y    - Data vectors (data points)
    %   xi      - Interpolation query point (scalar)
    %   method  - 1: linear, 2: quadratic (piecewise), 3: cubic spline
    %
    % Outputs:
    %   value_at_x - Interpolated value at xi
    %   coeffs     - Coefficients for each interval

    n = length(x);

    switch method
        case 1  % Linear interpolation (piecewise)
            value_at_x = interp1(x, y, xi, 'linear');
            coeffs = zeros(n-1, 2);  % [a0, a1] for each segment

            fprintf('Linear interpolation: y = a0 + a1*x\n');
            for i = 1:n-1
                a1 = (y(i+1) - y(i)) / (x(i+1) - x(i));  % Slope
                a0 = y(i) - a1 * x(i);  % Intercept
                coeffs(i, :) = [a0, a1];
                fprintf('  Segment [%g, %g]: a0 = %.4f, a1 = %.4f\n', x(i), x(i+1), a0, a1);

                % Evaluate at xi if it's in this interval
                if xi >= x(i) && xi <= x(i+1)
                    value_at_x = a0 + a1 * xi;
                end
            end

        case 2  % Piecewise quadratic interpolation
            coeffs = [];
            value_at_x = NaN;

            fprintf('Quadratic interpolation (piecewise): y = a0 + a1*x + a2*x^2\n');

            for i = 1:n-2
                xi_seg = x(i:i+2);
                yi_seg = y(i:i+2);
                p = polyfit(xi_seg, yi_seg, 2);  % [a2, a1, a0]
                a0 = p(3); a1 = p(2); a2 = p(1);
                coeffs = [coeffs; [a0, a1, a2]];

                fprintf('  Interval [%g, %g]: a0 = %.4f, a1 = %.4f, a2 = %.4f\n', ...
                    x(i), x(i+2), a0, a1, a2);

                % Evaluate at xi if it's within this local window
                if xi >= x(i) && xi <= x(i+2)
                    value_at_x = polyval(p, xi);
                    fprintf('  Evaluated value at xi = %.4f: %.4f\n', xi, value_at_x);
                end
            end

        case 3  % Cubic spline interpolation with global x coefficients
            pp = csape(x, y, 'second');  % Natural spline
            value_at_x = NaN;
            rawCoeffs = pp.coefs;  % [a3, a2, a1, a0] in (x - x_i)
            coeffs = [];  % to store [a0, a1, a2, a3] in global x

            fprintf('Cubic spline segments: y = a0 + a1*x + a2*x^2 + a3*x^3\n');

            for i = 1:length(pp.breaks)-1
                a3 = rawCoeffs(i,1);
                a2 = rawCoeffs(i,2);
                a1 = rawCoeffs(i,3);
                a0 = rawCoeffs(i,4);
                x0 = pp.breaks(i);

                % Convert from local (x - x0)^n to global x^n
                % f(x) = a3*(x - x0)^3 + a2*(x - x0)^2 + a1*(x - x0) + a0
                % Expand this to global x^3 + x^2 + x + 1 form
                A3 = a3;
                A2 = -3*a3*x0 + a2;
                A1 = 3*a3*x0^2 - 2*a2*x0 + a1;
                A0 = -a3*x0^3 + a2*x0^2 - a1*x0 + a0;

                coeffs = [coeffs; [A0, A1, A2, A3]];

                fprintf('  Interval [%g, %g]: a0 = %.4f, a1 = %.4f, a2 = %.4f, a3 = %.4f\n', ...
                        pp.breaks(i), pp.breaks(i+1), A0, A1, A2, A3);

                if xi >= pp.breaks(i) && xi <= pp.breaks(i+1)
                    value_at_x = A0 + A1*xi + A2*xi^2 + A3*xi^3;
                    fprintf('  Evaluated value at xi = %.4f: %.4f\n', xi, value_at_x);
                end
            end

        otherwise
            error('Invalid method. Choose 1 (linear), 2 (quadratic), or 3 (cubic spline).');
    end
end