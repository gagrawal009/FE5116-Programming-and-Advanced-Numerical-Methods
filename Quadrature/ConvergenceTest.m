% l: correct value
function d=ConvergenceTest( f, a, b, I )

   m = ceil( 2.^[2:10] );

   for i=1:length(m),
		er(i)=abs(Rectangle(f,0, 0.75*pi(), m(i))-I);
		em(i)=abs(MidPoint (f,0, 0.75*pi(), m(i))-I);
		et(i)=abs(Trapezoid(f,0, 0.75*pi(), m(i) )-I);
		es(i)=abs(Simpson(f,0, 0.75*pi(),   m(i))-I);
		esr(i)=abs(SimpsonRichardson(f,0, 0.75*pi(),   m(i))-I);
   end

   clf,
   loglog( m, er, m, em);
   hold on,
   loglog( m+1, et)
   loglog(2*m+1, es, 2*m+1, esr );
   legend( 'rectangle', 'midpoint', 'trapezoid', 'simpson', 'simpson-richardson' );
   lx=xlabel( 'n' ); set(lx, 'fontsize', 26);
   ly=ylabel( 'error' ); set(ly, 'fontsize', 26);
   hold off
end
