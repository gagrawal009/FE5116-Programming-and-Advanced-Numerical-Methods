% m: number of compoiste intervals
function I=SimpsonDemo( f, a, b, m )

   n=2*m;

   x=[a:(b-a)/100:b];

   clf
   hold on
   xlim([-0.1, 2.5]);

   h = (b-a)/n;

   xi = [a+[0:n]*h];
   yi = f(xi);

   plot( xi, yi, 'or', 'MarkerSize', 6, 'MarkerFaceColor', 'r', 'linestyle', 'none' );

   for i=1:2:length(xi)-1
	  xx = xi(i:i+2)'; yy=yi(i:i+2)';
	  p = vander(xx) \ yy;
	  xxx = [xx(1):(xx(3)-xx(1))/20:xx(3)];
	  yyy = polyval( p, xxx );

	  area( xxx, yyy, 'facecolor', 'g', 'edgecolor', 'r' );
   end

    plot(x, f(x), 'b', 'LineWidth', 2)

   hold off

   I=Simpson( f, a, b, m )

