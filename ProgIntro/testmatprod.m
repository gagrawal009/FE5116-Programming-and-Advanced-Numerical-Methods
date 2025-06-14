function testmatprod(n)
	myrand = @() floor (1 + 10 * rand (1, 1));
	for i=1:n,
		x = rand(myrand(),myrand());
		ok = sum(sum(abs((matprod(x,x') - x*x')))) < 1e-14;
		if(~ok)
			disp('matprod test failed'),
			error( x )
		end
	end
	disp('matprodtest succsses')
end
