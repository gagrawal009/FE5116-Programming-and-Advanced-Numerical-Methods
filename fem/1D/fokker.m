function [x,t,p,s]=fokker(model,x,ts,tk)

  p0=model.ivp(x,ts(1));

  H=mkMatrix(@mass,x);
  F=mkMatrix(model.stiffness,x);

  [F,zeroL] = model.lowBoundary(x,F);

  % remove first and last column and rows (Diricheliet) and integrate
  vars=1+zeroL:length(x)-1;
  p=integratepdf(x(vars),p0(vars),ts,H(vars,vars),F(vars,vars));

  % remove intermediate steps
  t=ts(tk);
  p=p(:,tk);

  % add back first and last variables
  z=zeros(1,columns(p));
  if (zeroL)
	 p=[z;p;z];
  else
	 p=[p;z];
  end

  % compute integrals
  if (nargout>3),
	 s=simpson(x,p);
  end









