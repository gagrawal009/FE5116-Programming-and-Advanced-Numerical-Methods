% valuation of an american put option in a trinomial tree
% @d@, @m@, @u@ are returns over a timesptep, on down-middle-up nodes, @pm@ amd @pu@ are probabilities of up and middle nodes
% @N@ is the number of steps, @rf@ the risk-free rate, @T@ the option maturity
% @spot@ the current spot level and @strike@ is the strike
function val = americanTrinomialVec( u, m, d, pm, pu, N, rf, T, spot, payoff )
	ratioMD = m / d;
	df = exp( -rf * T / N );
	pd = 1.0 - pm - pu;
	nNodes = 1 + 2 * N;

	lastLowest = spot * d ^ N;
	prices = lastLowest * ratioMD .^ ((0 : nNodes - 1)');

	v = payoff( prices );

	for tS = N:-1:1
		l = length( prices ) - 2;
		prices = prices( 1:l ) ./ d;
		v = max( payoff( prices ), df * ( pu * v( 3:l+2 ) + pm * v( 2:l+1 ) +  pd * v( 1:l ) ) );
	end
	val = v( 1 );
end
