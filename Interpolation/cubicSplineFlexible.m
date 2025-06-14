function [value_at_x, coeffs] = cubicSplineFlexible(x, y, xi, leftBCtype, rightBCtype)
    % Cubic spline interpolation with 'natural' or 'clamped' boundary conditions
    % Inputs:
    %   x, y           - data vectors
    %   xi             - interpolation query point
    %   leftBCtype     - 'natural' or 'clamped'
    %   rightBCtype    - 'natural' or 'clamped'
    % Outputs:
    %   value_at_x     - interpolated value at xi
    %   coeffs         - global [a0, a1, a2, a3] for each segment

    % Check if both ends use the same type
    if strcmpi(leftBCtype, rightBCtype)
        if strcmpi(leftBCtype, 'natural')
            pp = csape(x, y, 'second');
        elseif strcmpi(leftBCtype, 'clamped')
            % Estimate endpoint slopes using central difference
            hL = 0.005 * x(1);
            hR = 0.005 * x(end);
            f = @(xx) interp1(x, y, xx, 'pchip', 'extrap');
            d0 = (f(x(1) + hL) - f(x(1) - hL)) / (2 * hL);
            dn = (f(x(end) + hR) - f(x(end) - hR)) / (2 * hR);
            pp = csape(x, y, 'clamped', [d0, dn]);
        else
            error('Unknown boundary type: use ''natural'' or ''clamped''.');
        end
    else
        error('csape does not support mixed boundary types. Use both ''natural'' or both ''clamped''.');
    end

    % Evaluate the spline at xi
    value_at_x = ppval(pp, xi);

    % Convert local (x - x0)^n coefficients to global x^n coefficients
    rawCoeffs = pp.coefs;
    coeffs = [];

    for i = 1:length(pp.breaks)-1
        a3 = rawCoeffs(i,1);
        a2 = rawCoeffs(i,2);
        a1 = rawCoeffs(i,3);
        a0 = rawCoeffs(i,4);
        x0 = pp.breaks(i);

        % Transform to global x
        A3 = a3;
        A2 = -3*a3*x0 + a2;
        A1 = 3*a3*x0^2 - 2*a2*x0 + a1;
        A0 = -a3*x0^3 + a2*x0^2 - a1*x0 + a0;

        coeffs = [coeffs; [A0, A1, A2, A3]];
    end
end