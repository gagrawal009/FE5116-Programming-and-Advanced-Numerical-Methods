%     mySin5( x )
% Approximation of Sin( x ) on [-pi,pi] by taylor expansion using
% symmetry
% x (double)
function sinx = mySin6( x )

	pi = 3.14159265358979;
	halfPi = 1.5707963267949;

	if ( x > halfPi )
		sinx = mySin7( pi - x );
	elseif ( x < -halfPi )
		sinx = -mySin7( pi + x );
	else
		sinx = mySin7( x );
	end




function sinx = mySin7( x )

	pi = 3.14159265358979;
	if ( x < 0.0 )
		y= -x;
	else
		y= x;
	end

	if ( y < pi * 0.25 )
		sinx = mySin1( y );
	elseif ( y < pi * 0.5 + 1.0e-8 )
		sinx = myCos1( pi * 0.5 - y );
	end

	if ( x < 0.0 )
		sinx= -sinx;
	end

