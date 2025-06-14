function [x, y] = implicit_euler(ode, ys, xs, xe, n)
    % Implicit Euler method (Backward Euler)
    % ode : function handle @(x,y) -> dy/dx = f(x,y)
    % ys  : initial condition
    % xs  : starting x
    % xe  : ending x
    % n   : number of intervals

    h = (xe - xs) / n;
    x = linspace(xs, xe, n+1);
    y = zeros(n+1, length(ys));
    y(1,:) = ys;
    
    for j = 1:n
        % We need to solve: y_{j+1} = y_j + h * f(x_{j+1}, y_{j+1})
        % Using simple fixed-point iteration or Newton-Raphson for nonlinear problems
        % For now, simple fixed-point:
        
        y_guess = y(j,:); % initial guess: previous value
        for k = 1:10 % few iterations to approximate
            y_guess = y(j,:) + h * ode(x(j+1), y_guess);
        end
        y(j+1,:) = y_guess;
    end
end
