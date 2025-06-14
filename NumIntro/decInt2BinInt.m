% Author: Fabio Cannizzo
%
% y = decInt2BinInt (x)
%

function m=decInt2BinInt( x, nbits )
   % Note the use of the function sprintf to construct the error message
   assert(x>=0, 'n must be positive, but you entered: %d\n', x);
   assert(x == uint64(x), 'n must be integer, but you entered: %d\n', x);

   m=zeros(1,nbits); % initialize with nbits zeros
   p = 1;
   for i=1:nbits
      t = p*2;
      if mod(x,t) ~= 0  % is x not divisible by t ?
         x=x-p;
         m(nbits+1-i)=1;
      end
      p=t;
   end

   % transform to the ascii values for zero and one
   % and convert to string
   m = char(m + '0');
end


