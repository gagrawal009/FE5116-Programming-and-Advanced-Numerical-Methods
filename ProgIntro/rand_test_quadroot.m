function rand_test_quadroot()

    for i=1:100
        % we generate random roots in [-5,5]
        z = sort(10 * (rand(1,2) - 0.5)); % testing roots in [-5, 5]
        % generate a random coefficient 'a' in [0,4]
        a = 4*rand(1,1);

        % we compute the coefficients b and c, knowing that
        % a x^2 + b x + c = a (x-r1)(x-r2)
        c = a*z(1)*z(2);
        b = -a*(z(1)+z(2));

        % compute the roots using the formula
        res = sort( quadroot(a,b,c) );

        % compare the computed roots with the original ones
        % if we check for equality, it always fail
        ok = min(abs(z-res) < 1e-12) == 1;
        %ok = min(z==res) == 1;  % this would fail

        if ( ~ok )  % if there is an error, print info and stop
            coefficients=[a,b,c]
            expected=z
            got=res
            difference=z-res
            error('something wrong')
        end
    end

    disp('test pass')
end
