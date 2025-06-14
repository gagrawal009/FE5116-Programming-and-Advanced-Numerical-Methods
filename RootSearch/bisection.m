% Author: Fabio Cannizzo
%
% bisection.m
%
% res = bisection (f, a, b, eps )
%
% f   : function handle
% a   : begin of interval
% b   : end of interval
% eps : accuracy

function [c,info] = bisection( f, a, b, eps )
    fa = f(a);
    fb = f(b);
    i  = 1; info = [];  % just for display
    assert(fa*fb < 0, 'f(a)f(b)>=0' );
    while (b-a > eps)
        c  = (a+b)/2;
        fc = f(c);
        info(i,:)=[i, c, a, b, b-a]; i=i+1; % just for display
        if (fc*fa<0)
            b = c;
        elseif fc == 0
            return
        else
            a = c; fa = fc;
        end
    end
end



