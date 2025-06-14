%
% Author: Fabio Cannizzo
%

function dt=measureTime(fun, nRepeat, dryRun, args)
	% dry run: one-off initialization costs (e.g. compiling the m file)
	if (dryRun), fun(args); end

	tStart=tic;
	% total cost of the loop is nRepeat*costOf(fun)
	% if nRepeat is large enough, this will dominate on the cost of time()
	% and will be material with respect to the accuracy ot time()
	for i=1:nRepeat,
		fun(args);
	end
	dt=toc(tStart)/nRepeat;
