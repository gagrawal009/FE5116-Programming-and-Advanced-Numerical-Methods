function payoff = calculateGBMPayoffAnti(F0, sigma, deltaT, epsilon1, epsilon2)
    % Euler discretization for the primary path
    F_deltaT = F0 + sigma * F0 * sqrt(deltaT) * epsilon1;
    
    F_2deltaT = F_deltaT + sigma * F_deltaT * sqrt(deltaT) * epsilon2;
    
    % Euler discretization for the antithetic path
    F_deltaT_antithetic = F0 + sigma * F0 * sqrt(deltaT) * (-epsilon1);
    F_2deltaT_antithetic = F_deltaT_antithetic + sigma * F_deltaT_antithetic * sqrt(deltaT) * (-epsilon2);
    
    % Calculate payoffs
    payoff_primary = max(F_2deltaT - F_deltaT, 0);
    payoff_antithetic = max(F_2deltaT_antithetic - F_deltaT_antithetic, 0);
    
    % Average payoff
    payoff = (payoff_primary + payoff_antithetic) / 2;
    
    % Display result
    disp(['The antithetic variance-reduced payoff is: ', num2str(payoff)]);
end
