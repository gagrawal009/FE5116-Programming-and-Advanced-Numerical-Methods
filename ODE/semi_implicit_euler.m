function [x, y] = semi_implicit_euler(ode, y0, x0, xe, n)
% SEMI_IMPLICIT_EULER General semi-implicit Euler method for ODEs
%
% Solves dy/dx = f(x,y) using: 
% y_{i+1} = y_i + h/2*[f(x_i,y_i) + f(x_{i+1},y_{i+1})]
%
% Input:
%   ode : function handle dy/dx = ode(x,y) (can be vector-valued)
%   y0  : initial condition (scalar or vector)
%   x0  : initial x
%   xe  : end x
%   n   : number of steps
%
% Output:
%   x   : vector of x values
%   y   : solution matrix (each row corresponds to x value)

    h = (xe - x0)/n;               % Step size
    x = linspace(x0, xe, n+1)';    % Column vector of x values
    y = zeros(n+1, length(y0));    % Preallocate solution matrix
    y(1,:) = y0;                   % Initial condition
    
    for i = 1:n
        % Current values
        x_i = x(i);
        y_i = y(i,:)';
        
        % Evaluate f(x_i, y_i)
        f_i = ode(x_i, y_i);
        
        % First guess for y_{i+1} (explicit Euler)
        y_im1_guess = y_i + h * f_i;
        
        % Fixed-point iteration to solve implicit equation
        max_iter = 100;
        tol = 1e-8;
        for iter = 1:max_iter
            f_im1 = ode(x(i+1), y_im1_guess);
            y_new = y_i + (h/2) * (f_i + f_im1);
            
            if norm(y_new - y_im1_guess) < tol
                break;
            end
            y_im1_guess = y_new;
        end
        
        y(i+1,:) = y_new';
    end
end