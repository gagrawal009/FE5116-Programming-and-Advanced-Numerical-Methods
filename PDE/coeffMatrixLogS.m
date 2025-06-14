% Construct coefficinet matrix for the log process X=lnS,
% where S is a Geometric Brownian motion with constant parameters
% dX = (mu -0.5*vol*vol) dt + vol dW
% over a equally spaced grid xgrid
% with time step dt
function [Z, xgrid, h] = coeffMatrixLogS(minX, maxX, nX, r, y, vol, dt)
    % compute constants
    mu = r - y;
    sig2 = vol * vol;
    k = dt;
    xgrid = linspace(minX, maxX, nX)';
    h = xgrid(2) - xgrid(1);
    d = (mu - sig2 / 2 ) / (2*h);
    s = sig2 / (2 * h * h);
    
    % set up the matrix z
    % note that the first and last rows are all zeros
      % set up the matrix Z
    Z = zeros(nX, nX);
    row = k * [ d  -  s
              r + sig2 / (h * h)
               -d  - s
            ]';
    for i = 2:nX-1
        Z(i, i-1:i+1) = row;
    end

end
