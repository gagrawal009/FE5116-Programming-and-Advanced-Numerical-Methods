% Black Scholes explicit pde pricer using S as the state variable
% Compute the price of a European option with generic 'payoff' function
% Use Diricheliet boundary condition
function [pv,sgrid, pvs] = euroExplicitDirichelietS(spot, T, r, y, sigma, payoff, nT, nS)
  % grid geometry
  minS = spot * min(0.99, exp((r-y)*T + norminv(10e-7)   * sigma*sqrt(T)));
  maxS = spot * max(1.01, exp((r-y)*T + norminv(1-10e-7) * sigma*sqrt(T)));
  k = T / nT; % time step: equally spaced grid in T
  [Z, sgrid] = coeffMatrixS(minS, maxS, nS, r, y, sigma, k);

  % initial value problem
  pvs = payoff(sgrid);

  % auxiliary data
  A = eye(nS) - Z;
  R = zeros(nS,1);  % used for boundary conditions
    
  for i = 1:nT
    % set Diricheliet boundary condition vector
    dt = k * i;  % time to maturity
    fdf = exp(-r * dt); % forward discount factor
    fwdFactS = exp((r-y)*dt); % spot forward factor
	R(1) = payoff(minS * fwdFactS) * fdf - pvs(1);
	R(nS) = payoff(maxS * fwdFactS) * fdf - pvs(nS);
    
    % explicit scheme step
	pvs = A * pvs + R;
  end
  
  pv = interp1( sgrid, pvs, spot, 'linear');
end
