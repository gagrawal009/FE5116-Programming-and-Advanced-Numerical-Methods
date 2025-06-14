%      mySin4( x, eps )
% Approximation of Sin( x ) on [-pi,pi] by taylor expansion using
% adaptative number of terms. The function returns once the contribution
% of a term of the series becomes less than eps.
% x (double)
% eps (double)
function sinx = mySin4( x, eps )

    x2 = x * x;
    aux = x;
    sinx = x;
    n = 1;

    % stop when conctribution less than eps
    while(abs( aux ) >= eps)
        n = n + 2;
        aux = aux * (-x2) / ( n - 1 ) / n; % term of order n
        sinx = sinx +  aux; % addition of the term to the series
    end


