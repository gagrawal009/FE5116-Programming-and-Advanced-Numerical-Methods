% arguments( x, y, z )
% Demo input/output arguments handling.
function [u, v, w]= arguments( x, y, z )

    % we use fprintf to construct messages
	fprintf( 'The number of input arguments is : %d\n', nargin );
	fprintf( 'The number of output arguments requested is : %d\n', nargout );

	if ( nargin == 0 )
		error( 'Need at least one argument' );
	end
	if ( nargin == 1 )
		u = x;
		if ( nargout > 1 )
			error( 'One argument is returned only !' );
		end
	end
	if ( nargin == 2 )
		u = x;
		v = [y, y]';
		if ( nargout > 2 )
			error( 'Two arguments are returned only !' );
		end
	end
	if ( nargin == 3 )
		u = x;
		v = [y, y]';
		w = [z z];
	end
end
