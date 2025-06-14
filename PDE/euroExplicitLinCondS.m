% Black Scholes explicit pde pricer using S as the state variable
% Compute the price of a European option with generic 'payoff' function
% Use Linear Condition boundary condition
function [pv,sgrid, pvs] = euroExplicitLinCondS(spot, T, r, y, sigma, payoff, nT, nS)
  % grid geometry
  minS = spot * exp((r-y)*T + norminv(10e-7)     * sigma*sqrt(T));
  maxS = spot * exp((r-y)*T + norminv(1-10e-7) * sigma*sqrt(T));
  k = T / nT ; % time step: equally spaced grid in T
  [Z, sgrid] = coeffMatrixS(minS, maxS, nS, r, y, sigma, k);

  % initial value problem
  pvs = payoff(sgrid);

  % auxiliary data
  A = eye(nS) - Z;
  % modify first and last row to set the linear condition
  A(1,1:3)=[0 2 -1]; A(end,end-2:end)=[-1 2 0];
    
  for i = 1:nT
    % explicit scheme step
	pvs = A * pvs;
  end
  
  pv = interp1( sgrid, pvs, spot, 'linear');
end
