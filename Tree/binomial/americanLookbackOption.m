function price = americanLookbackOption(u, d, spot, T, N, rf, yield, method)
% Pricing American Lookback Options (Floating Strike)
% u: up factor (e.g., 1.1)
% d: down factor (e.g., 0.9)
% spot: initial stock price (any positive value, including <1)
% T: time to maturity (years)
% N: number of time steps (must be integer)
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

% Track min/max prices
minTree = stockTree; % Initialize with current prices
maxTree = stockTree;

for i = 2:N+1
    for j = 1:i
        if j == 1
            prev_min = minTree(1,i-1);
            prev_max = maxTree(1,i-1);
        else
            prev_min = minTree(j-1,i-1);
            prev_max = maxTree(j-1,i-1);
        end
        current_price = stockTree(j,i);
        minTree(j,i) = min(prev_min, current_price);
        maxTree(j,i) = max(prev_max, current_price);
    end
end

% Initialize option value tree
optionTree = zeros(N+1, N+1);

% Terminal payoff
for j = 1:N+1
    S = stockTree(j,N+1);
    S_min = minTree(j,N+1);
    S_max = maxTree(j,N+1);
    
    if strcmpi(method, 'call')
        optionTree(j,N+1) = max(S - S_min, 0); % Lookback call
    elseif strcmpi(method, 'put')
        optionTree(j,N+1) = max(S_max - S, 0); % Lookback put
    else
        error('Method must be "call" or "put"');
    end
end

% Backward induction with early exercise
for i = N:-1:1
    for j = 1:i
        S = stockTree(j,i);
        S_min = minTree(j,i);
        S_max = maxTree(j,i);
        
        % Continuation value
        cont_value = exp(-r*dt) * (p * optionTree(j,i+1) + (1-p) * optionTree(j+1,i+1));
        
        % Early exercise value
        if strcmpi(method, 'call')
            early_exercise = max(S - S_min, 0);
        else
            early_exercise = max(S_max - S, 0);
        end
        
        optionTree(j,i) = max(cont_value, early_exercise);
    end
end

price = optionTree(1,1);
end