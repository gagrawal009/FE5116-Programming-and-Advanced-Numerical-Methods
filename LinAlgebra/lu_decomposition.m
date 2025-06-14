function [L, U] = lu_decomposition(A)
    % Get the size of the matrix
    [n, ~] = size(A);
    
    % Initialize L and U
    L = eye(n);    % L starts as the identity matrix
    U = zeros(n);  % U starts as a zero matrix
    
    % Begin LU decomposition
    for k = 1:n
        % For U matrix (row k)
        U(k, k:end) = A(k, k:end);
        
        % For L matrix (column k)
        for i = k+1:n
            L(i,k) = A(i,k) / U(k,k);
            A(i,k:end) = A(i,k:end) - L(i,k) * U(k,k:end); % Update rows
        end
    end
end
