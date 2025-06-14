% m: number of composite intervals
function I = Trapezoid( f, a, b, m )

   h = (b-a)/m;

   yi = f( a+[0:m]*h );

   I = h * ( 0.5 *(yi(1)+yi(m+1)) + sum(yi(2:m)) );
end

