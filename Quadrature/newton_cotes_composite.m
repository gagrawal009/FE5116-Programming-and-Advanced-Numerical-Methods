function I = newton_cotes_composite(f, a, b, n, method, m)
    % f      – function handle
    % [a,b]  – interval
    % n      – number of sub-intervals per composite segment
    % method – 'closed' or 'open'
    % m      – number of composite intervals
    
    h_total = (b - a) / m;  % Width of each composite interval
    I = 0;

    for k = 1:m
        % Subinterval [a_k, b_k]
        a_k = a + (k-1)*h_total;
        b_k = a + k*h_total;
        
        % Apply Newton-Cotes to the subinterval
        I_k = newton_cotes_general(f, a_k, b_k, n, method);
        I = I + I_k;
    end
end