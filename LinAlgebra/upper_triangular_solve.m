function X=upper_triangular_solve(A, B)
	n = size(A,1);
	assert(n == size(A,2), 'A must be square');
	assert(n == size(B,1), 'inconsistent matrix dimensions');
	X = B;
	X(n,:) = X(n,:) / A(n,n);
	for r=n-1:-1:1
		X(r,:) = (B(r,:) - A(r,r+1:end) * X(r+1:end,:) ) / A(r,r);
	end
