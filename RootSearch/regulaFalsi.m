%
% 	regulaFalsi( f, a, b, yAcc )
%
% rootsearching by regulaFalsi method
% Input:
%     f is a real numeric function s.t. f( a ) * f( b ) < 0.0
%     xAcc convergence threshold
%     nIter max number of iterations
% Output
%    c: solution
%    info: information about the algorithm    
function [c, info] = regulaFalsi( f, a, b, yAcc )

    fb = f( b ); fa = f( a );

    assert( fa * fb < 0.0, 'f( a ) * f( b ) >= 0.0' );

    % init loop variables
    c = a; iter = 1; exit = false;
    info = []; % unnecessary, just for display

    while(~exit)
        cOld = c;     % save previous value of c. Guard for infinite loop
        c  = a - fa * ( b  - a ) / ( fb - fa );  % new point
        fc = f( c );

        if ( fc * fb < 0.0 )  % update interval
            a  = c; fa = fc;
        else
            b  = c; fb = fc;
        end

        info(iter,:)=[iter, c]; iter=iter+1;  % unnecessary, just for display

        exit = ( abs(fc) <= yAcc || cOld == c ); % Exit criteria is on yAcc.
    end
end
