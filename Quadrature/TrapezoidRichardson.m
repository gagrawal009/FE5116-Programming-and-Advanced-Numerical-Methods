function I = Trapezoid( f, a, b, n )

   h = (b-a)/n;

   yi = f( a+[0:n]*h );

   I = h * ( 0.5 *(yi(1)+yi(n+1)) + sum(yi(2:n)) );
end
