function X = lower_triangular_solve(L, B)
    % Solves LX = B for lower triangular L using forward substitution
    % Input:
    %   L - Lower triangular matrix (n x n)
    %   B - Right-hand side matrix (n x m)
    % Output:
    %   X - Solution matrix (n x m)

    n = size(L, 1);
    assert(n == size(L, 2), 'L must be square');
    assert(n == size(B, 1), 'Inconsistent dimensions');
    
    X = zeros(size(B)); % Initialize solution
    
    % First row (no dependencies)
    X(1,:) = B(1,:) / L(1,1);
    
    % Forward substitution for remaining rows
    for r = 2:n
        X(r,:) = (B(r,:) - L(r, 1:r-1) * X(1:r-1,:)) / L(r,r);
    end
end