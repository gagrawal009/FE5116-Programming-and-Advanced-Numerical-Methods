function I = SimpsonRichardson( f, a, b, m )

   n = 2 * m;
   assert(n>=4);

   h = (b-a)/n;

   yi = f( a+[0:n]*h );

   I=h*( yi(1)+yi(n+1) + 2*sum(yi(3:2:n-1)) + 4*sum(yi(2:2:n)) )/3;

   I1=Calc( yi, h );
   I2=Calc( yi(1:2:n+1), 2*h );
   I = (16*I1-I2)/15;
end


function I=Calc(yi,h)
   n = length(yi)-1;
   I=h*( yi(1)+yi(n+1) + 2*sum(yi(3:2:n-1)) + 4*sum(yi(2:2:n)) )/3;
end
