% n: number of composite intervals
function I=RectangleDemo( f, a, b, m )

   x=[a:(b-a)/100:b];

   clf
   hold on
   xlim([-0.1, 2.5]);

   h = (b-a)/m;

   xi = [a+[0:m-1]*h];
   yi = f(xi);

   for i=1:length(xi)
	  xs = xi(i);
	  xe = xi(i)+h;

	  bar( xi(i)+h/2, yi(i), h, 'g' );
      plot( [xs, xs, xe, xe], [ 0, yi(i), yi(i), 0 ], 'r' );plot( [xs, xs, xe, xe], [ 0, yi(i), yi(i), 0 ], 'r' );
   end

   plot(x, f(x), 'b', 'LineWidth', 2),
   plot( xi, yi, 'or', 'MarkerSize', 6, 'MarkerFaceColor', 'r' );

   hold off

   I=Rectangle( f, a, b, m )
end
