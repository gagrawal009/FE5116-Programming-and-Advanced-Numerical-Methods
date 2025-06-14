% m: number of composite intervals
function I=TrapezoidDemo( f, a, b, m )

   x=[a:(b-a)/100:b];

   clf
   hold on
   xlim([-0.1, 2.5]);

   h = (b-a)/m;

   xi = [a+[0:m]*h];
   yi = f(xi);

   plot( xi, yi, 'or', 'MarkerSize', 6, 'MarkerFaceColor', 'r', 'linestyle', 'none' );

   for i=1:length(xi)-1
	  area( xi(i:i+1), yi(i:i+1), 'facecolor', 'g', 'edgecolor', 'r' );
   end

   plot(x, f(x), 'b', 'LineWidth', 2)

   hold off

   I=Trapezoid( f, a, b, m )
end
