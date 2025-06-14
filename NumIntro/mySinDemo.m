
function mySinDemo

	x= 1.0;
	fprintf( 'sin(0.5) taylor %g\n', mySin1( 1.0 ) );
	fprintf( 'sin(0.5) built-in %g\n', sin( 1.0 ) );

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
	[ax, h1, h2] = plotyy( x, [y1; y2; y3], x, [ abs( y2 - y1 ); abs( y3 - y2 ) ] );
	xlabel( 'x' )
	ylabel( ax(1), 'sin(x)' )
	ylabel( ax(2), 'error(x)' )
	legend( [h1; h2], 'mySin1', 'sin', 'mySin5', 'error mySin1', 'error mySin5')
	saveas( 1, 'mySin.png');

	figure(5)
	semilogy( x, [ abs( y2 - y1 ); abs( y3 - y2 ) ] );
	title( 'Error mySin1-mySin5 in logarithmic scale ' )
	xlabel( 'x' )
	ylabel( ax(1), 'sin(x)' )
	ylabel( ax(2), 'error(x)' )
	legend( 'error mySin1', 'error mySin5')


	figure(2)
	[ax, h1, h2] = plotyy( x, [y2; y5], x, abs( y5 - y2 ) );
	xlabel( 'x' )
	ylabel( ax(1), 'sin(x)' )
	ylabel( ax(2), 'error(x)' )
	legend( [h1; h2], 'sin', 'mySin2', 'error mySin2')
	saveas( 2, 'mySin2.png');

	figure(3)
	[ax, h1, h2] = plotyy( x, [y2; y4], x, abs( y4 - y2 ) );
	xlabel( 'x' )
	ylabel( ax(1), 'sin(x)' )
	ylabel( ax(2), 'error(x)' )
	legend( [h1;h2], 'sin', 'mySin4', 'error mySin4')
	saveas( 3, 'mySin4.png');

	figure(4)
	[ax, h1, h2] = plotyy( x, [y2; y6], x, abs( y6 - y2 ) );
	xlabel( 'x' )
	ylabel( ax(1), 'sin(x)' )
	ylabel( ax(2), 'error(x)' )
	legend( [h1; h2], 'sin', 'mySin3', 'error mySin3')
	saveas( 4, 'mySin3.png');




