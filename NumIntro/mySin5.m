%     mySin5( x )
% Approximation of Sin( x ) on [-pi,pi] by taylor expansion using
% symmetry
% x (double)
function sinx = mySin5( z )

	pi = 3.14159265358979;
	halfPi = 1.5707963267949;
	sinx=zeros(size(z));

	for i=1:length(z)
		x=z(i);
		if ( x > halfPi )
			sinx(i) = mySin1( pi - x );
		elseif ( x < -halfPi )
			sinx(i) = -mySin1( pi + x );
		else
			sinx(i) = mySin1( x );
		end
	 end




