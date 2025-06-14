function val = americanBinomialPricerln(U, D, p, T, N, rf, logSpot, payoff)
    % U, D: up and down moves in log space (i.e., additive)
    % logSpot: ln(S_0)
    
    q = 1.0 - p;
    df = exp(-rf * T / N);  % discount factor per step

    v = zeros(N + 1, 1);

    % Starting from lowest node at maturity (most down moves)
    X = logSpot - N * D;  % corresponds to j = 1
    lastLowest = X;

    % Terminal payoff
    for j = 1:N+1
        S = exp(X);  % Convert log-price to price
        v(j) = payoff(S);
        X = X + (U + D);  % move to next node up
    end

    % Backward induction
    for tS = N:-1:1
        lastLowest = lastLowest + D;  % move one step up from last level
        X = lastLowest;
        for j = 1:tS
            S = exp(X);
            continuation = df * (p * v(j + 1) + q * v(j));
            v(j) = max(payoff(S), continuation);  % American option: early exercise
            X = X + (U + D);
        end
    end

    val = v(1);  % Option price at root
end
