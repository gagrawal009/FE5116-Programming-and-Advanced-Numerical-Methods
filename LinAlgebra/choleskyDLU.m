function [D, L, U] = choleskyDLU(A)
    D = diag(diag(A));
    L = tril(A, -1);
    U = triu(A, 1);
end
