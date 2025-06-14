function x = ieee754binary2double(b)
% Input: b - binary vector of 64 elements (0s and 1s)
% Output: x - the floating point number according to IEEE-754 double-precision

    if length(b) ~= 64
        error('Input must be a 64-element binary vector');
    end
    
    % Extract parts
    signBit = b(1);
    exponentBits = b(2:12);
    fractionBits = b(13:64);

    % Calculate sign
    signVal = (-1)^signBit;
    
    % Calculate exponent
    exponentVal = bin2dec(num2str(exponentBits)) - 1023;
    
    % Handle special cases (Inf, NaN, denormals)
    if all(exponentBits == 0)
        % Subnormal number
        fractionVal = 0;
        for i = 1:length(fractionBits)
            fractionVal = fractionVal + fractionBits(i) * 2^(-i);
        end
        x = signVal * 2^(exponentVal + 1) * fractionVal;
    elseif all(exponentBits == 1)
        if any(fractionBits)
            x = NaN;  % Not a number
        else
            x = signVal * Inf;  % Infinity
        end
    else
        % Normalized number
        fractionVal = 1;
        for i = 1:length(fractionBits)
            fractionVal = fractionVal + fractionBits(i) * 2^(-i);
        end
        x = signVal * 2^exponentVal * fractionVal;
    end
end
