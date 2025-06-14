function I = newton_cotes_general(f,a,b,n,method)
    % f      – function handle
    % [a,b]  – interval
    % n      – number of sub-intervals
    % method – 'closed' or 'open'
    
    h = (b - a)/n;
    
    switch method
        case 'closed'
            % closed: nodes i = 0..n
            xi = a + (0:n)*h;
            indices = 0:n;
            mult = n;
        case 'open'
            % open: nodes i = 1..n-1
            xi = a + (1:n-1)*h;
            indices = 1:n-1;
            mult = n;
        otherwise
            error('method must be ''open'' or ''closed''');
    end

    % compute weights w_i = ∫₀¹ ∏_{j∈indices\{i}}(mult*x - j) dx  /  ∏_{j∈indices\{i}}(i - j)
    w = zeros(size(indices));
    for k = 1:length(indices)
        i = indices(k);
        % build numerator function
        numf = @(x) ones(size(x));
        for j = indices
            if j~=i
                numf = @(x) numf(x).*(mult*x - j);
            end
        end
        % denominator
        den = 1;
        for j = indices
            if j~=i
                den = den*(i - j);
            end
        end
        w(k) = integral(numf,0,1)/den;
    end

    % display weights
    for k=1:length(indices)
        fprintf('w_{%d} = %.8f\n', indices(k), w(k));
    end

    % approximate integral
    I = (b - a)*sum( w .* arrayfun(f, xi) );
end
