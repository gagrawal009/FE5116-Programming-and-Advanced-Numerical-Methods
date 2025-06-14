function num = fbinary2number(binVec)
% FBINARY2NUMBER Convert a binary vector (0s and 1s) to a decimal number
% Example: binVec = [1 0 1 1] → output = 11

    % Check if input is only 0 and 1
    if any(binVec ~= 0 & binVec ~= 1)
        error('Input must be a vector containing only 0s and 1s.');
    end

    % Convert binary vector to number
    binStr = num2str(binVec);     % Convert to string with spaces
    binStr = binStr(binStr ~= ' '); % Remove spaces
    num = bin2dec(binStr);         % Use built-in function
end
