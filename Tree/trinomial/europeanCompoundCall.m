function val = europeanCompoundCall(u, m, d, pm, pu, N, rf, T, spot, payoffPut, strike_compound)
    % Assumes:
    % T: maturity of the American Put (e.g. 3 years)
    % N: total number of steps (e.g. 3)
    % spot: current stock price
    % payoffPut: function handle for Put payoff
    % strike_compound: strike of the compound call (e.g. 0.7)

    dt = T / N;  % timestep size
    df = exp(-rf * dt);
    pd = 1 - pm - pu;

    % ---- Step 1: Stock prices after first step (t = dt) ----
    ratioMD = m / d;
    S1 = spot * d * (ratioMD .^ (0:2)');  % 3 nodes after one step

    % ---- Step 2: Price American Put from each node with remaining steps ----
    remainingSteps = N - 1;
    remainingTime = T - dt;
    putValues = zeros(3, 1);
    for i = 1:3
        putValues(i) = americanTrinomialVec(u, m, d, pm, pu, remainingSteps, rf, remainingTime, S1(i), payoffPut);
    end

    % ---- Step 3: Evaluate compound call payoff ----
    compoundPayoff = max(putValues - strike_compound, 0);

    % ---- Step 4: Discount back to present ----
    val = df * (pd * compoundPayoff(1) + pm * compoundPayoff(2) + pu * compoundPayoff(3));
end
