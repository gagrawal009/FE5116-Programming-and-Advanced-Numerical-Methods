
function Exercise2

	x= 1.0;
	fprintf( 'sin(0.5) taylor %g\n', mySin1( 1.0 ) );
	fprintf( 'sin(0.5) built-in %g\n', sin( 1.0 ) );

	x = [-pi:2*pi/1000:pi];
	y1 = mySin1( x );
	for i = 1:length(x)
		y3( i ) = mySin5( x( i ) );
		y7( i ) = mySin6( x( i ) );
	end
	y2 = sin( x );

	figure(1)
	[ax, h1, h2] = plotyy( x, [y2; y3], x, [ abs( y3 - y2 ) ] );
	xlabel( 'x' )
	ylabel( ax(1), 'sin(x)' )
	ylabel( ax(2), 'error(x)' )
	legend( [h1; h2], 'sin', 'mySin5','error mySin5')
	saveas( 1, 'mySin.png');

	figure(5)
	[ax, h1, h2] = plotyy( x, [y2; y7], x, abs( y7 - y2 ) );
	xlabel( 'x' )
	ylabel( ax(1), 'sin(x)' )
	ylabel( ax(2), 'error(x)' )
	legend( [h1; h2], 'sin', 'mySin6', 'error mySin6')
	saveas( 5, 'mySin4.png');



