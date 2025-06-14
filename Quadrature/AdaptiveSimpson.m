function [I,n] = AdaptiveSimpson( f, a, b, acc )

   h = (b-a)/2;
   c = a+h;
   fa = f(a);
   fc = f(c);
   fb = f(b);
   S1 = SimpsonStep( fa, fc, fb, h );

   [I,n] = RecursiveSimpson( f, a, c, b, fa, fc, fb, h/2, S1, acc );
   n = n+3;
end


function [I,n]=RecursiveSimpson(f, a, c, b, fa, fc, fb, h, S1, acc)

   % FIXME: we do not have a guard on minimum size of the interval (i.e. maximum depth or recursion), but we should!

   c1 = a+h;
   c2 = c+h;
   fc1 = f( c1 );
   fc2 = f( c2 );

   S21 = SimpsonStep( fa, fc1, fc, h );
   S22 = SimpsonStep( fc, fc2, fb, h );
   S2 = S21+S22;

   %keyboard

   if ( abs( S2 - S1 ) > 15*acc )
	   [S21,n1] = RecursiveSimpson( f, a, c1, c, fa, fc1, fc, h/2, S21, acc/2 );
	   [S22,n2] = RecursiveSimpson( f, c, c2, b, fc, fc2, fb, h/2, S22, acc/2 );
	   I = S21+S22;
	   n = 2 + n1 + n2;
   else
	   I = (16*S2-S1)/15;
	   n = 2;
   end
end


function I=SimpsonStep( y1, y2, y3, h )
   I = (y1+4*y2+y3)*h/3;
end
