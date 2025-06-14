%
% Author: Fabio Cannizzo
%

function [r,h]=heron(x)
	assert( x>=0, 'x must be positive' );
	rold = 0;
	r = 1;                     % arbitrary initialization
	h = [0,r];                 % just for display
	i = 1;
	while ( r ~= rold )        % maximum precision achieved?
	   rold=r;
	   r = 0.5 * ( r + x/r );  % heron step
	   h=[h; [ i, r] ];        % just for display
	   i=i+1;
	end
