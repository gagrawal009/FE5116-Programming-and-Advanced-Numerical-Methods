function [option_price, delta, cash] = no_arbitrage_pricing_put(S0, K, r, yield, T, N, u, d)
    % NO_ARBITRAGE_PRICING_PUT_YIELD Computes option price, delta, and cash position for a European put with dividend yield.
    % Inputs:
    %   S0: Initial stock price
    %   K: Strike price
    %   r: Risk-free rate
    %   yield: Continuous dividend yield
    %   T: Time to maturity (years)
    %   N: Number of steps
    %   u: Up-factor
    %   d: Down-factor
    % Outputs:
    %   option_price: Price of the put option
    %   delta: Hedge ratio at t=0
    %   cash: Cash position at t=0

    dt = T / N;                                  % Time per step
    q = (exp((r - yield) * dt) - d) / (u - d);   % Adjusted risk-neutral probability

    % Initialize stock and option value trees
    stock_tree = zeros(N+1, N+1);
    option_tree = zeros(N+1, N+1);

    % Build stock price tree
    for i = 1:N+1
        for j = 1:i
            stock_tree(j, i) = S0 * u^(i-j) * d^(j-1);
        end
    end

    % Calculate option payoffs at maturity (for put)
    option_tree(:, end) = max(K - stock_tree(:, end), 0);

    % Backward induction for option price
    for i = N:-1:1
        for j = 1:i
            option_tree(j, i) = exp(-r * dt) * ...
                (q * option_tree(j, i+1) + (1 - q) * option_tree(j+1, i+1));
        end
    end
    option_price = option_tree(1, 1);

    % Compute delta and cash at t=0 (first step)
    delta = (option_tree(1, 2) - option_tree(2, 2)) / ...
            (stock_tree(1, 2) - stock_tree(2, 2));
    cash = option_price - delta * S0;
end
