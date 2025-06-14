function ypp = second_derivative(f, x, h, method)
    % Second derivative using finite difference methods
    % f      : Function handle for the function whose derivative is to be calculated
    % x      : The point at which the second derivative is to be evaluated
    % h      : Step size for the finite difference approximation
    % method : 'left' | 'right' | 'central' (Select method for finite difference)

    switch lower(method)
        case 'central'
            % Central difference approximation for the second derivative
            f_xh = f(x + h);  % f(x+h)
            f_x = f(x);       % f(x)
            f_xmh = f(x - h); % f(x-h)
            ypp = (f_xh - 2*f_x + f_xmh) / (h^2);
            
        case 'right'
            % Right difference approximation for the second derivative
            f_xh = f(x + h);  % f(x+h)
            f_x2h = f(x + 2*h); % f(x+2h)
            ypp = (f_x2h - 2*f_xh + f_x) / (h^2);

        case 'left'
            % Left difference approximation for the second derivative
            f_xmh = f(x - h);  % f(x-h)
            f_x2mh = f(x - 2*h); % f(x-2h)
            ypp = (f_x - 2*f_xmh + f_x2mh) / (h^2);
            
        otherwise
            error('Invalid method. Choose "left", "right", or "central".');
    end
end
