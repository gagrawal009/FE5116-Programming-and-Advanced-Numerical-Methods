function [Z1, Z2] = boxMuller(U1, U2)
    R = sqrt(-2 * log(U1));
    V = 2 * pi * U2;
    Z1 = R .* cos(V);
    Z2 = R .* sin(V);
end
