function [paths] = genPaths(mu, vol, S0, T, nT, nsim)

	dt = T / nT;

	drift=(mu-0.5*vol^2)*dt;
	diff = vol*sqrt(dt);

	paths = zeros(nT + 1, nsim);
	paths(1,:) = S0;

	for t=1:nT
		paths(t+1, :) = paths(t, :) .* exp( drift + diff * randn(1, nsim) );
    end

    lastValue = paths(end,:);
    logn = @(x)lognpdf(x,log(S0)+(mu-0.5*vol^2)*T, vol*sqrt(T));

    figure(2)
    plot(paths(:, 1:min(100, nsim)));
    figure(1)
    H=histogram(lastValue,'Normalization','pdf')
    hold on
    plot(H.BinEdges,logn(H.BinEdges), 'LineWidth', 2);
    hold off

	display( ['expectation (empirical)     ', num2str(mean(lastValue)) ] );
	display( ['expectation (theoretical)   ', num2str(S0*exp(mu*T)) ] );

	display( ['log-variance (empirical):   ', num2str(var(log(lastValue))) ] );
	display( ['log-variance (theoretical): ', num2str(vol^2*T) ] );
