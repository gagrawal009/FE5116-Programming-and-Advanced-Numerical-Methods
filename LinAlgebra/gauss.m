% Solves the system AX=B via Gaussian triangularization
% partial = 1: partial pivoting, 0: total pivoting
function X=gauss(A,B,partial)
	if (nargin < 3)
	   partial = 1;
	end

	% check matrix dimensions
	assert(size(A,1) == size(B,1), 'A and B must have the same number of rows');
	assert(size(A,1) == size(A,2), 'A must be square');

	% for processing convenience, append B to A
	AB = [A,B];
	if(partial)
	   X = gauss_partial(AB);
	else
	   X = gauss_total(AB);
	end


function X=gauss_partial(AB)
	[n,m] = size(AB);

	% triangularization
	for rp = 1:n-1  % rp is the index of the pivot row
		% find index of largest element in absolute value
		% in the lower part of column m
		[~, rm] = max(abs(AB(rp:n, rp)));
		colidx = uint32(rp:m);
		if (rm ~= 1)
			rm = rm + rp - 1;
			% move row rm to pivot position by swapping rows r and rm
			AB([rp,rm],colidx) = AB([rm,rp],colidx);
		end
		% reduce rows
		for ri = rp+1:n
			pivot = AB(ri,rp) / AB(rp,rp);
			AB(ri,colidx) = AB(ri,colidx) - AB(rp,colidx) * pivot;
		end
	end
	X = upper_triangular_solve(AB(:,1:n), AB(:,n+1:m));


function X=gauss_total(A,B)
	error('not implemented')


