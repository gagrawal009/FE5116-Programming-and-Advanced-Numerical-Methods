function y=oumk(x0,kappa,theta,sigma)
   y.a=@(x)kappa*(theta-x);
   y.ax=@(x)-kappa;
   y.b=@(x)sigma;
   y.bx=@(x)0;

   y.theta=theta;
   y.kappa=kappa;
   y.sigma=sigma;

   y.x0=x0;

   y.ivp=@(x,t)oupdf(x,t,y);

   %y.stiffness=@(x,dx,n,z)stiffness(x,dx,n,z,y); % default implementation
   y.stiffness=@(x,dx,n,z)auxstiff(x,dx,n,z,y); % specialized implementation

   y.lowBoundary=@nullBoundary;


function y=auxstiff(x,dx,n,z,cf)
   s=cf.sigma;
   th=cf.theta;
   k=cf.kappa;
   driftterm=k*(dx*(imat(n,z)+rmat(n,z))+(x-th)*jmat(n,z));
   diffterm=(0.5*s*s/dx)*kmat(n,z);
   y= driftterm-diffterm;
