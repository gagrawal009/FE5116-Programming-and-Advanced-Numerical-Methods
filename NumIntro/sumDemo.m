% dec2bin
%
% Author: Fabio Cannizzo
%

function r = sumDemo (n)
	r=[single([1:n])',single(zeros(n,4))];
	for i=1:n,
		k=1/r(i,1);
		for j=1:i,
			r(i,2)=r(i,2)+k;
		end,
		r(i,3) = 1-r(i,2);
		r(i,4) = kahan( k*single( ones(1,i) ) );
		r(i,5) = 1-r(i,4);
    end
end

