%      mySin1( x )
% Approximation of Sin( x ) by taylor expansion of order 7
function sinx = mySin1( x )

	c3 = -0.1666666666666667;   % 1/3!, pre-calculated
	c5 = 8.333333333333333e-3;  % 1/5!
	c7 = -1.988412698412698e-4; % 1/7!
	x2 = x .* x;

	sinx = x .* ( 1.0 + x2 .* ( c3 + x2 .* ( c5 + c7 .* x2 ) ) ); % Horner rule
end

