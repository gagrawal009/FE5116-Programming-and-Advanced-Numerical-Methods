function [L, steps] = lowerTriangularizationWithSteps(A)
    % Input: A square matrix A
    % Output: 
    %   L - Lower triangular matrix (with zeros above diagonal)
    %   steps - Cell array showing intermediate steps
    
    steps = {};
    n = size(A, 1);
    L = A;
    
    for k = n:-1:2  % Process columns right-to-left
        % Partial pivoting (swap rows to avoid zero pivots)
        [~, max_row] = max(abs(L(k:n, k)));  % Find pivot in current column
        max_row = max_row + k - 1;  % Adjust index
        
        if max_row ~= k
            L([k, max_row], :) = L([max_row, k], :);  % Swap rows
            steps{end+1} = sprintf('Swapped row %d with row %d:', k, max_row);
            steps{end+1} = L;
        end
        
        % Eliminate entries above the pivot
        for i = k-1:-1:1
            if L(k, k) == 0
                error('Zero pivot encountered. Matrix may be singular.');
            end
            factor = L(i, k) / L(k, k);
            L(i, :) = L(i, :) - factor * L(k, :);
            
            steps{end+1} = sprintf('Eliminated row %d using row %d:', i, k);
            steps{end+1} = L;
        end
    end
    
    % Display steps
    fprintf('=== Lower Triangularization Steps ===\n');
    for i = 1:length(steps)
        if ischar(steps{i})
            fprintf('\n%s\n', steps{i});
        else
            disp(steps{i});
        end
    end
    fprintf('\nFinal Lower Triangular Matrix:\n');
    disp(tril(L));  % Enforce zeros above diagonal for display
end