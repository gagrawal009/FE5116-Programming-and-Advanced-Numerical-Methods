% Black Scholes pde pricer using S as the state variable
% Compute the price of a European option with generic 'payoff' function
% Use Diricheliet boundary condition
% w = 1: explicit, 0: implicit, 0.5: CranK Nicholson
function [pv, sgrid, pvs] = euroDouglasDirichelietS(spot, T, r, y, sigma, payoff, nT, nS, w)
  % grid geometry
  minS = spot * exp((r-y)*T + norminv(10e-7)     * sigma*sqrt(T));
  maxS = spot * exp((r-y)*T + norminv(1-10e-7) * sigma*sqrt(T));
  k = T /  nT; % time step: equally spaced grid in T
  [Z, sgrid] = coeffMatrixS(minS, maxS, nS, r, y, sigma, k);

  % matrix associated with the implicit solution
  MI = eye(nS) + (1-w) * Z;

  % matrix associated with the explicit solution
  ME = eye(nS) - w * Z;
  
   % initial value problem
  pvs = payoff(sgrid);

  % pre-compute useful matrices
  [L U P] = lu(MI);  % lu factorization: L U = P MI
  % hints about matrix structure used by linsolve
  l_hint.LT = true; % l is solwer triangular
  u_hint.UT = true; % u is upper triangular
  R = zeros(nS,1); % vector used for Diricheliet conditions
  
  for i = 1:nT

    % set Diricheliet
    dt = k * i;  % time to maturity
    fdf = exp(-r * dt); % discount factor
    fwdfact = exp((r-y)*dt);
	% set Diricheliet boundary condition
	R(1) = payoff(minS * fwdfact) * fdf - pvs(1);
	R(nS) = payoff(maxS * fwdfact) * fdf - pvs(nS);
    
   % explicit scheme step
	pvs = ME * pvs + R;

    % solve system using l, u and p matrices
	% we use linsolve so that we can hint to the solver that the
	% matrices are triangular, does avoiding unnecessary checks
	% (see linsolve documentation)
	b = P * pvs; % permute right hand side vector
	z = linsolve(L, b, l_hint);    % first step of LU solution
	pvs = linsolve(U, z, u_hint);   % second step of LU solution
  end
  
  pv = interp1( sgrid, pvs, spot, 'linear');
end
