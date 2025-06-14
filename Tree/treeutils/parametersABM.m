function [ localMean, localVar ] = parametersABM( rf, yield, vol, T, N )
	dt = T ./ N;
    localVar = vol .* vol .* dt;
    localMean = ( rf - yield - 0.5 * vol .* vol) .* dt;
end
