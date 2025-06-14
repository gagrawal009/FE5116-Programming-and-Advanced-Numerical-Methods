%      mySin3( x )
% Approximation of Sin( x ) on [-pi,pi] by taylor expansion using
% adaptative number of terms and maximum possible precision
% x (double)
function sinx = mySin3( x )

    x2 = x * x;
    aux = x;
    sinx = x;
    n = 1;
    oldsinx = 0;
    
    % stop when sinx does not change anymore
    while(oldsinx ~= sinx)
        oldsinx = sinx;
        n = n + 2;
        aux = aux * (-x2) / ( n - 1 ) / n; % term of order n
        sinx = sinx + aux; % addition of the term to the series
    end
