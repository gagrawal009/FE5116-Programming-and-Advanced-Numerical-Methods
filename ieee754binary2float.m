function x = ieee754binary2float(b)
% Input: b - binary vector of 32 elements (0s and 1s)
% Output: x - the floating point number according to IEEE-754

    if length(b) ~= 32
        error('Input must be a 32-element binary vector');
    end
    
    % Extract parts
    signBit = b(1);
    exponentBits = b(2:9);
    fractionBits = b(10:32);

    % Calculate sign
    signVal = (-1)^signBit;
    
    % Calculate exponent
    exponentVal = bin2dec(num2str(exponentBits)) - 127;
    
    % Calculate fraction
    fractionVal = 1;  % Start with 1 because IEEE normalized numbers assume 1.xxxx
    for i = 1:length(fractionBits)
        fractionVal = fractionVal + fractionBits(i) * 2^(-i);
    end

    % Final value
    x = signVal * 2^exponentVal * fractionVal;
end
