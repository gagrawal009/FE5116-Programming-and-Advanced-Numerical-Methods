function val = europeanCompoundOptionFromAmericanTrinomial(u, m, d, pm, pu, N, rf, T1, T2, spot, payoffInner, payoffCompound)
    % Uses the americanTrinomialVec function to compute the inner option value
    % and prices a European compound option with maturity T2 < T1.
    %
    % Inputs:
    %   u, m, d         - up, middle, down factors
    %   pm, pu          - probabilities for middle and up
    %   N               - number of total steps for full tree to T1
    %   rf              - risk-free rate
    %   T1              - maturity of inner option (the underlying)
    %   T2              - maturity of compound option
    %   spot            - current spot price
    %   payoffInner     - function for inner (underlying) with T1 maturity
    %   payoffCompound  - function : V -> compound payoff with T2 maturity
    %
    % Output:
    %   val             - value of the compound option

    if T2 >= T1
        error('T2 (compound option maturity) must be before T1 (underlying option maturity)');
    end

    N2 = round(N * T2 / T1);  % steps to compound maturity
    N1 = N;                   % total steps to inner option maturity

    dt = T1 / N1;
    df = exp(-rf * dt);
    pd = 1 - pm - pu;
    ratioMD = m / d;

    % Step 1: Compute all possible spot prices at time T2
    nNodes = 1 + 2 * N2;
    lastLowest = spot * d^N2;
    spot_T2 = lastLowest * ratioMD .^ ((0:nNodes - 1)');

    % Step 2: For each of those spots at T2, compute the value of the underlying
    % American option (from T2 to T1) using americanTrinomialVec
    V = zeros(size(spot_T2));
    for i = 1:length(spot_T2)
        V(i) = americanTrinomialVec(u, m, d, pm, pu, N - N2, rf, T1 - T2, spot_T2(i), payoffInner);
    end

    % Step 3: Apply the compound option payoff on these values
    compoundPayoff = payoffCompound(V);

    % Step 4: Backpropagate compound option value from T2 to time 0
    for tS = N2:-1:1
        l = length(compoundPayoff) - 2;
        spot_T2 = spot_T2(1:l) ./ d;
        compoundPayoff = df * (...
            pu * compoundPayoff(3:l+2) + ...
            pm * compoundPayoff(2:l+1) + ...
            pd * compoundPayoff(1:l));
    end

    val = compoundPayoff(1);
end
