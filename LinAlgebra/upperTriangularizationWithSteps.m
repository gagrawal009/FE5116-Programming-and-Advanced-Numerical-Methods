function [U, steps] = upperTriangularizationWithSteps(A)
    % Input: A square matrix A
    % Output: 
    %   U - Upper triangular matrix
    %   steps - Cell array showing intermediate matrices
    
    steps = {}; % Store each step for display
    n = size(A, 1);
    U = A; % Copy of A to modify
    
    for k = 1:n-1
        % Step 1: Partial Pivoting (find row with largest pivot in column k)
        [~, pivot_row] = max(abs(U(k:n, k)));
        pivot_row = pivot_row + k - 1;
        
        % Swap rows if needed
        if pivot_row ~= k
            U([k, pivot_row], :) = U([pivot_row, k], :);
            steps{end+1} = sprintf('Swapped rows %d and %d:', k, pivot_row);
            steps{end+1} = U;
        end
        
        % Step 2: Elimination for rows below pivot
        for i = k+1:n
            factor = U(i, k) / U(k, k);
            U(i, k:n) = U(i, k:n) - factor * U(k, k:n);
            
            steps{end+1} = sprintf('Eliminated row %d using row %d:', i, k);
            steps{end+1} = U;
        end
    end
    
    % Display all steps
    fprintf('=== Gaussian Elimination with Partial Pivoting ===\n');
    for i = 1:length(steps)
        if ischar(steps{i})
            fprintf('\n%s\n', steps{i});
        else
            disp(steps{i});
        end
    end
end