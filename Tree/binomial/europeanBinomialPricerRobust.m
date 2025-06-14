% The function europeanBinomialPricer does not work with large N, because
% the probability (1-p)^N drops to zero and because the variable 'binom'
% overflows. For example with 2000 steps, the following fails
% europeanBinomialPricer(0.99,1.01,0.5,1,2000,0,10,(@(x)max(x-10,0)))
% This is a more stable alternative implementation which supports large
% number of steps
function res = europeanBinomialPricerRobust( d, u, p, T, N, rf, spot, payoff )
    j = [0:N]';
    % use Matlab builtin binomial pdf function
    probs  = binopdf(j, N, p);
    % use log for stability
    prices = exp(log(spot) + j * log(u) + (N-j)*log(d));
    values = payoff(prices);
	res = exp( -rf * T ) * sum(values .* probs);
end

