% m: number of composite intervals
function I = Simpson( f, a, b, m )

   n = 2 * m;

   h = (b-a)/n;

   yi = f( a+[0:n]*h );

   I=h*( yi(1)+yi(n+1) + 2*sum(yi(3:2:n-1)) + 4*sum(yi(2:2:n)) )/3;
end

