% m: number of composite intervals
function I = Rectangle( f, a, b, m )

   h = (b-a)/m;

   yi = f( a+[0:m-1]*h );

   I=h*sum(yi);
end
