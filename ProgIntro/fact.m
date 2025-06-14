function y=fact(n)
   % In the main function we do some error checks, which do not need to 
   % repeat during the recursion
   % Note the use of the function sprintf to construct the error message
   assert(n>=0, 'n must be positive, but you entered: %d\n', n );
   assert(n == uint64(n), 'n must be integer, but you entered: %d\n', n );

   % now that we know that n is good, we start the recursion
   y = fact2(n);
end


function y=fact2(n)
   % set the terminating condition for n<=1, instead of n==0,
   % so we save one one recursive function call
   if (n <= 1)
	  y = 1;
   else
	  y = n * fact2(n - 1);
   end
end
