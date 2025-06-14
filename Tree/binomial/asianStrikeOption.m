function price = asianStrikeOption(u, d, spot, T, N, rf, yield, method)
% Pricing Asian Strike Option (Arithmetic Average Strike)
% u: up factor
% d: down factor
% spot: initial stock price
% T: time to maturity in years
% N: number of time steps
% rf: risk-free rate (annual)
% yield: dividend yield (annual)
% method: 'call' or 'put'

dt = T/N;
q = yield;
r = rf;

% Risk-neutral probability
p = (exp((r-q)*dt) - d)/(u - d);

% Initialize stock price tree
stockTree = zeros(N+1, N+1);
stockTree(1,1) = spot;

for i = 2:N+1
    stockTree(1,i) = stockTree(1,i-1) * u;
    for j = 2:i
        stockTree(j,i) = stockTree(j-1,i-1) * d;
    end
end

% Calculate average prices at each node
avgTree = zeros(N+1, N+1);
avgTree(1,1) = spot;

for i = 2:N+1
    for j = 1:i
        if j == 1
            prev_avg = avgTree(1,i-1);
            avgTree(j,i) = (prev_avg*(i-1) + stockTree(j,i))/i;
        else
            prev_avg = avgTree(j-1,i-1);
            avgTree(j,i) = (prev_avg*(i-1) + stockTree(j,i))/i;
        end
    end
end

% Initialize option value tree
optionTree = zeros(N+1, N+1);

% Terminal payoff
for j = 1:N+1
    if strcmpi(method, 'call')
        optionTree(j,N+1) = max(stockTree(j,N+1) - avgTree(j,N+1), 0);
    elseif strcmpi(method, 'put')
        optionTree(j,N+1) = max(avgTree(j,N+1) - stockTree(j,N+1), 0);
    else
        error('Method must be either "call" or "put"');
    end
end

% Backward induction
for i = N:-1:1
    for j = 1:i
        optionTree(j,i) = exp(-r*dt) * (p * optionTree(j,i+1) + (1-p) * optionTree(j+1,i+1));
    end
end

price = optionTree(1,1);
end