function [basis,dbasis]=mkBasis()
   persistent basis = {
	@(x)2.*(x-1).*(x-0.5)
	@(x)-4.* x.*(x-1)
	@(x)2.*x.*(x-0.5)
	};

   persistent dbasis = {
	  @(x)4.*x-3;
	  @(x)-(8.*x-4);
	  @(x)4.* x-1;
	};

