% errorout( x )
% generate errors
function errorout( x )

	if ( x > 1 )
		error( 'Expected argument to be no greater than 1' );
	end

	assert( x > -1.0, 'Expected argument to be greater than -1' );

end

