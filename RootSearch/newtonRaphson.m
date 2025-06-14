%
% 	newtonRaphson( f, boundLow, tol )
%
% rootsearching by newton-raphson method
%
% f : is a real derivable numeric function
% fp : its derivative
% x0 : a starting point
% nInter : number of iterations
% xAcc : accuracy parameter
function [x,h] = newtonRaphson( f, fp, x, xAcc, nIter )

	found = 0; h=[];

	for i= 1:nIter  % the limit on nIter is a guard for infinite loops

		xOld = x;
		x = x - f( x ) / fp( x ); % update x
		h(i,:)=[i, x]; % unnecessary, just for display

		% exit criteria on xAcc. we could also have on yAcc
		if ( abs( x - xOld ) < xAcc )
			found = 1;
			break;
		end

	end

	assert( found, 'Maximum number of iterations exceeded ' )
end
