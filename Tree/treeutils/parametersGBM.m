function [ localMean, localVar ] = parametersGBM( rf, yield, vol, T, N )
	dt = T ./ N;
    localMean = exp( ( rf - yield ) .* dt );
	localVar = localMean .^ 2 .* exp( vol.*vol.* dt );
end
