% dec2bin
%
% Author: Fabio Cannizzo
%
% [s,a,e,d] = fpdec2bin (x, nBitMantissa, nBitExp)
%

function [binstr,s,a,n]=fpdec2bin( x, nBitMantissa, nBitExp, bitOffset )
   if x<0, s=1; x=-x; else, s=0; end
   a=zeros(1,nBitMantissa);
   n=floor(log2(x));
   r = x/(2^n)-1;
   i = 1;
   while (r>0 && i<=nBitMantissa)
	  r = 2*r;
	  if r>=1
		 r=r-1;
		 a(i)=1;
	  end
	  i=i+1;
   end
   n=dec2bin(n+bitOffset,nBitExp);
   binstr = [num2str(s), '-'];
   for i=1:nBitExp binstr=strcat(binstr,num2str(n(i))); end
   binstr = [binstr, '-'];
   for i=1:nBitMantissa binstr=strcat(binstr,num2str(a(i))); end

