function val = europeanTrinomialVec(u, m, d, pm, pu, N, rf, T, spot, payoff)
    % Compute discount factor per step
    df = exp(-rf * T / N);
    pd = 1.0 - pm - pu;
    
    % Total number of terminal nodes: 1 + 2*N
    nNodes = 1 + 2 * N;

    % Asset prices at maturity
    ratioMD = m / d;
    lastLowest = spot * d^N;
    prices = lastLowest * ratioMD .^ ((0:nNodes-1)');
    
    % Payoff at terminal nodes
    v = payoff(prices);
    
    % Backward induction: no early exercise
    for tS = N:-1:1
        l = length(prices) - 2;
        prices = prices(1:l) ./ d; % reverse the down move
        v = df * (pu * v(3:l+2) + pm * v(2:l+1) + pd * v(1:l));
    end

    val = v(1); % Option value at the root node
end
