function [root, iter] = fixedPointIteration(g, g_prime, x0, tol, maxIter)
    % g: The modified function g(x), where f(x) = 0 is rearranged to x = g(x)
    % g_prime: The first derivative of g(x) for checking convergence
    % f: The original function whose root is being solved
    % x0: Initial guess for the root
    % tol: Tolerance for stopping criterion (|x_{n+1} - x_n| < tol)
    % maxIter: Maximum number of iterations to prevent infinite loop
    
    % Initialize variables
    x = x0;
    iter = 0;
    
    % Check if the function g(x) satisfies the convergence condition
    if abs(g_prime(x0)) >= 1
        error('The chosen g(x) does not meet the convergence condition (|g''(x)| < 1)');
    end
    
    while iter < maxIter
        % Compute the next iteration using the fixed-point iteration
        x_new = g(x);
        
        % Check if the result is within tolerance
        if abs(x_new - x) < tol
            root = x_new;  % Found root within tolerance
            return;
        end
        
        % Update the current guess and increment iteration
        x = x_new;
        iter = iter + 1;
    end
    
    % If the loop ends without convergence, return the last approximation
    root = x;
    disp('Maximum iterations reached without convergence.');
end
