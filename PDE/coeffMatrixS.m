% Construct coefficinet matrix for a geometric
% Brownian motion with constant parameters
% dS/S = mu dt + vol dW
% over a equally spaced grid sgrid
% with time step dt
function [Z, sgrid, h] = coeffMatrixS(minS, maxS, nS, r, y, vol, dt)
    % compute constants
    mu = r - y;
    sig2 = vol * vol;
    k = dt;
    sgrid = linspace(minS, maxS, nS)';
    h = sgrid(2) - sgrid(1);
    
    % set up the matrix z
    % note that the first and last rows are all zeros
    Z = zeros(nS, nS);
    for i = 2:nS-1
        Z(i, i-1) = (mu - sig2 * sgrid(i) / h) * k * sgrid(i) / (2 * h); % Ai
        Z(i, i) = k * (sig2 * sgrid(i) * sgrid(i) / (h * h) +  r); % Bi
        Z(i, i+1) = -(mu + sig2 * sgrid(i) / h) * k * sgrid(i) / (2 * h);  % Ci
    end
end
