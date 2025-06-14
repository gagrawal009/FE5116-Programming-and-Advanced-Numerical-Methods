%
% Author: Fabio Cannizzo
%

function [r,h]=heron2(x)
	assert( x>=0, 'x must be positive' );
	[z,p] = log2( x );    % mantissa in [0.5,1]
	if mod(p,2)  % is the exponent odd?
	   z=z*2;
	   p=p-1;
	end
	h = [];          % h is just for display
	r = 1;           % arbitrary initialization
	for i=1:5        % exactly five iterations
	   r = 0.5 * ( r + z/r );  % heron step
	   h=[h; [ i, r] ];        % h is just for display
	end
	r = pow2( r, p/2 );           % add back exponent
	h(:,2) = pow2( h(:,2), p/2 ); % h is just for display
