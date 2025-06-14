function [c, info] = regulaFalsiIllinois(f, a, b, yAcc, nIter)
    % Input:
    %   f     : Function handle (e.g., f = @(x) exp(sin(0.9*x)) - 0.5)
    %   a, b  : Interval endpoints where f(a)*f(b) < 0
    %   yAcc  : Convergence threshold for |f(c)| <= yAcc
    %   nIter : Maximum iterations (optional)
    % Output:
    %   c     : Approximate root
    %   info  : Iteration history [iteration, c, f(c), method_used]

    if nargin < 5
        nIter = 100; % Default max iterations
    end

    fa = f(a); fb = f(b);
    assert(fa * fb < 0, 'f(a) and f(b) must have opposite signs.');

    % Initialize variables
    c = a; 
    iter = 1; 
    exitFlag = false;
    info = zeros(nIter, 4); % [iter, c, f(c), method (0=standard, 1=Illinois)]
    lastKeptEndpoint = '';  % Track which endpoint was kept last ('a' or 'b')
    illinoisCounter = 0;    % Count steps since last Illinois adjustment

    while ~exitFlag && iter <= nIter
        cOld = c;

        % --- Illinois Modification ---
        if illinoisCounter > 0
            % After Illinois step, force at least 2 standard steps
            illinoisCounter = illinoisCounter - 1;
            method = 0; % Standard Regula-Falsi
            c = (a * fb - b * fa) / (fb - fa);
        else
            % Check if the same endpoint was kept twice
            if strcmp(lastKeptEndpoint, 'a') && (fa * f(cOld) > 0)
                method = 1; % Illinois adjustment for 'a'
                fa = fa / 2; % Halve fa
                c = (a * fb - b * fa) / (fb - fa);
                illinoisCounter = 2; % Force 2 standard steps next
            elseif strcmp(lastKeptEndpoint, 'b') && (fb * f(cOld) > 0)
                method = 1; % Illinois adjustment for 'b'
                fb = fb / 2; % Halve fb
                c = (a * fb - b * fa) / (fb - fa);
                illinoisCounter = 2; % Force 2 standard steps next
            else
                method = 0; % Standard Regula-Falsi
                c = (a * fb - b * fa) / (fb - fa);
            end
        end

        fc = f(c);
        info(iter, :) = [iter, c, fc, method];

        % Update interval
        if fc * fb < 0
            a = c; fa = fc;
            lastKeptEndpoint = 'b'; % 'b' was kept
        else
            b = c; fb = fc;
            lastKeptEndpoint = 'a'; % 'a' was kept
        end

        % Check convergence
        exitFlag = (abs(fc) <= yAcc) || (cOld == c);
        iter = iter + 1;
    end

    % Trim unused rows from info
    info = info(1:iter-1, :);
end