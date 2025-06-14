% m: number of composite intervals
function I = MidPoint( f, a, b, m )

   h = (b-a)/m;

   yi = f( a+([0:m-1]+0.5)*h );

   I=h*sum(yi);
end
