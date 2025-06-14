function [price, stderr] = exchangeOption(rf, yx, yy, sx, sy, rho, x0, y0, T, nsim)
   mux = rf - yx;
   muy = rf - yy;

   driftx = (mux - 0.5*sx^2)*T;
   drifty = (muy - 0.5*sy^2)*T;

   diffx = sx * sqrt(T);
   diffy = sy * sqrt(T);

   df = exp(-rf*T);  % discount factor

   L = chol([1.0 rho; rho 1.0]);  % compute cholesky matrix

   % seed random number generator with an arbitrary seed
   % use Mersenne Twister
   rng(1347,'twister');
   rnd_uncorrelated = randn(nsim, 2);
   rnd_correlated   = rnd_uncorrelated * L;
   xT = x0 * exp(driftx + diffx * rnd_correlated(:,1));
   yT = y0 * exp(drifty + diffy * rnd_correlated(:,2));
   payoff = max(0, xT - yT );

   price = df * mean(payoff);
   stderr = df * sqrt(var(payoff) / nsim);

