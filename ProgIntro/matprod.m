function c=matprod(a,b)
	[nRowA, nColA] = size(a);
	[nRowB,nColB] = size(b);

% 	if ( k ~= k2 )
% 		disp( 'Incompatible matrix dimension:' );
% 		error( ['(' num2str(m) ',' num2str(k) ') x (' num2str(k2) ',' num2str(n) ')'   ] );
% 	end
    assert( nColA==nRowB, ['Incompatible matrix dimension:' '(' num2str(nRowA) ',' num2str(nColA) ') x (' num2str(nRowB) ',' num2str(nColB) ')'  ]);

	c = zeros(nRowA,nColB);

	for i=1:nRowA
		for j=1:nColB
			for t=1:nColA
				c(i,j) = c(i,j) + a(i,t) * b(t,j);
			end
		end
	end
end
