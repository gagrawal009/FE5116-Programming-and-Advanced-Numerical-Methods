%     mySin2( x, nTerms )
% Approximation of Sin( x ) on [-pi,pi] by taylor expansion using
% specified number of terms
% x (double)
% nTerms (int) number of terms in the expansion
function sinx = mySin2( x, nTerms )
	assert ( nTerms >= 1, 'nTerms needs to be greater than 1' );

	x2 = -x * x;
	aux = x;
	sinx = x;

	for i = 2:nTerms
		n = 2 * i - 1;
		aux = aux * x2 / (( n - 1 ) * n); % term of order 2i-1
		sinx = sinx + aux; % addition of the term to the series
	end



