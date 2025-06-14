function y=cirmk(x0,kappa,theta,sigma)
   y.a=@(x)kappa*(theta-x);
   y.ax=@(x)-kappa;
   y.b=@(x)sigma;
   y.bx=@(x)0;

   y.theta=theta;
   y.kappa=kappa;
   y.sigma=sigma;

   y.x0=x0;

   y.ivp=@(x,t)priv_ivp(x,t,y);

   %y.stiffness=@(x,dx,n,z)stiffness(x,dx,n,z,y); % default implementation
   y.stiffness=@(x,dx,n,z)priv_stiffness(x,dx,n,z,y); % specialized implementation
   feller=2*kappa*theta>sigma*sigma;
   if (feller)
	  y.lowBoundary=@nullBoundary;
   else
	  y.lowBoundary=@(x,F)lowBoundary(x,F,kappa);
   end


function y=priv_ivp(x,t,cf)
   s=cf.sigma;
   th=cf.theta;
   k=cf.kappa;
   x0=cf.x0;
   ek=exp(-k*t);
   m=th+(x0-th)*ek;
   v=(s*s/k)*(th/2*(1-ek)^2+x*ek*(1-ek));
   y=normpdf(x,m,sqrt(v));


function y=priv_stiffness(x,dx,n,z,cf)
   s=cf.sigma;
   th=cf.theta;
   k=cf.kappa;
   drift=k*(dx*(imat(n,z)+rmat(n,z))+(x-th)*jmat(n,z));
   diffusion=(0.5*s*s)*(jmat(z,n)+qmat(n,z)+(x/dx)*kmat(n,z));
   y= drift-diffusion;


function [F,flag]=lowBoundary(x,F,kappa)
   if (x(1)>0)
	  flag=true;
   else
	  flag=false;
	  F(1,1)=F(1,1) - kappa;
   end
