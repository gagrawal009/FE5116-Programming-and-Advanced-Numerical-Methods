function [U, D] = parametersABMUD(mean, variance, p)
    delta = sqrt(variance / (p * (1 - p))); 
    U = mean + (1 - p) * delta;
    D = mean - p * delta;
end

