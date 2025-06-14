
% plot_demo
function demo_plot

	x = [-pi:2*pi/1000:pi];
	y1 = mySin1( x );
	for i = 1:length(x)
		y3( i ) = mySin5( x( i ) );
		y5( i ) = mySin2( x( i ), 5 );
		y4( i ) = mySin4( x( i ), 1.0e-5 );
		y6( i ) = mySin3( x( i ) );
	end
	y2 = sin( x );

	figure(1)
	[ax, h1, h2] = plotyy( x, [y1; y2; y3], x, [ abs( y2 - y1 ); abs( y3 - y2  ) ] );
	xlabel( 'x' )
	ylabel( ax(1), 'sin(x)' )
	ylabel( ax(2), 'error(x)' )
	legend( [h1; h2], 'mySin1', 'sin', 'mySin5', 'error mySin1', 'error mySin5')
	%saveas( 1, 'mySin.png');

	figure(2)
	x2 = [1.0e-5 :2*pi/1000 : pi - 1.0e-5 ];
	y1 = mySin1( x2 );
	y2 = sin( x2 );
	y3 = zeros(1, length( x2 ));
	for i = 1:length( x2 )
		y3( i ) = mySin5( x2( i ) );
	end
	semilogy( x2, [ abs( y2 - y1  ); abs( y3 - y2 ) ] )
	title( 'Error mySin1-mySin5 in logarithmic scale ' )
	xlabel( 'x' )
	legend( 'error mySin1', 'error mySin5')



