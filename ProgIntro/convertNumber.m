function representation = convertNumber(number, method)
    % CONVERTNUMBER Converts a number to binary, decimal, or hexadecimal representation
    %
    % Inputs:
    %   number - The number to be converted (must be a non-negative integer)
    %   method - The target representation: 'binary', 'decimal', or 'hexadecimal'
    %
    % Output:
    %   representation - The converted number as a string in the specified format
    
    % Validate input
    if ~isnumeric(number) || number < 0 || mod(number, 1) ~= 0
        error('Input must be a non-negative integer.');
    end
    
    % Convert based on the specified method
    switch lower(method)
        case 'decimal'
            representation = num2str(number);
        case 'binary'
            representation = dec2bin(number);
        case 'hexadecimal'
            representation = dec2hex(number);
        otherwise
            error('Invalid method. Choose ''binary'', ''decimal'', or ''hexadecimal''.');
    end
end