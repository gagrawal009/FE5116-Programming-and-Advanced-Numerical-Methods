function [Z1, Z2] = polarRejection()
    while true
        U1 = 2 * rand() - 1;  % Uniform(-1, 1)
        U2 = 2 * rand() - 1;  % Uniform(-1, 1)
        S = U1^2 + U2^2;
        
        if S > 0 && S < 1
            Y = sqrt(-2 * log(S) / S);
            Z1 = U1 * Y;
            Z2 = U2 * Y;
            return;
        end
        % Otherwise, reject and resample
    end
end
