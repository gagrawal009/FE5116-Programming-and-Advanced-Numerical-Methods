% Black Scholes pde pricer using ln(S) as the state variable
% Compute the price of a European option with generic 'payoff' function
% Use linbear boundary condition
% w = 1: explicit, 0: implicit, 0.5: Crank Nicholson
% The payoff must be expressed in the variable S, not logS
function [pv, sgrid, pvs] = euroDouglasLinCondLogS(spot, T, r, y, vol, payoff, nT, nS, w)

  % compute constants
  mu = r - y;
  sig2 = vol * vol;
  drift = (mu - 0.5 * sig2) * T;

  % set the range of S to be 5 standard deviation of X at expiry
  range = 5 * vol * sqrt(T);
  maxX = log(spot) + drift + range;
  minX = log(spot) + drift - range;

  % equally spaced T and X dimensions
  k = T / nT;

  [Z, xgrid, h] = coeffMatrixLogS(minX, maxX, nS, r, y, vol, k);

  % function which transforms from X to S
  x2s = @(x)(exp(x));

  % initial value problem
  sgrid = x2s(xgrid);
  pvs = payoff(sgrid);

  % matrix for explicit step
  ME = eye(nS) - w * Z;
  % modify first and last row to set the linear condition
  ME(1,1:3) = [0, 4/(2+h) , -(2-h)/(2+h)];
  ME(end,end-2:end) = [-(2+h)/(2-h), 4/(2-h),  0];
   
  % matrix for implicit step
  MI = eye(nS) + (1-w) * Z;
  % modify first and last row to set the linear condition
  MI(1,1:3) = [2+h, -4, 2-h];
  MI(end,end-2:end) = [2+h, -4, 2-h];
  
  % pre compute implicit scheme matrices
  [L U P] = lu(MI);  % lu factorization: L U = P MI
  % hints about matrixt structure used by linsolve
  l_hint.LT = true; % l is solwer triangular
  u_hint.UT = true; % u is upper triangular

  for i = 1:nT
   % explicit scheme step
	pvs = ME * pvs;
    
    % implicit step
    b = pvs;
    b([1,end]) = 0; % set to zero because of the linear condition
    b = P * b; % permute right hand side vector
	z = linsolve(L, b, l_hint);    % first step of LU solution
    pvs = linsolve(U, z, u_hint);   % second step of LU solution
    
  end

  pv = interp1( sgrid, pvs, spot, 'linear');

end
