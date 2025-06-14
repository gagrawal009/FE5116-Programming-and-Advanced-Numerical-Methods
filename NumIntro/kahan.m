%
% Author: Fabio Cannizzo
%

function sum=kahan(data)
	sum = 0.0;
	c = 0.0;          % A running compensation for lost low-order bits.
	for i = 1:length(data)
		y = data(i) - c;    % So far, so good: c is zero.
		t = sum + y;        % Alas, sum is big, y small, so low-order digits of y are lost.
		c = (t - sum) - y;  % (t - sum) recovers the high-order part of y; subtracting y recovers -(low part of y)
		sum = t;            % Algebraically, c should always be zero. Beware eagerly optimising compilers!
		% Next time around, the lost low part will be added to y in a fresh attempt.
	end

