%
% 	secant( f, x0, x1, xAcc, nIter )
%
% rootsearching by secant method
%
% f is a real numeric function
% x0, x1 such that a root of f is thought to lie between
% nInter : number of iterations
% xAcc : accuracy
function [x1,h] = secant( f, x0, x1, xAcc, nIter )

	fx0 = f( x0 );

	found = 0; h=[];

	for i = 1:nIter  % the limit on nIter is a guard for infinite loops
		 x1Old = x1;
		 fx1   = f( x1 );
		 x1 = x1 - fx1 * ( x1  - x0 ) / ( fx1 - fx0 ); % update x1
		 h(i,:)=[i, x1]; % unnecessary, just for display

		 if ( abs( x1 - x1Old ) < xAcc ) % exit criteria
			found = 1;
			break;
		 end

		 x0  = x1Old;  % update x0
		 fx0 = fx1;    % update fx0
	end

	assert( found, 'Maximum number of iterations exceeded ' )
end


