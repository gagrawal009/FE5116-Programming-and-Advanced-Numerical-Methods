function y=abmmk(x0,mu,sigma)
   y.a=@(x)mu;
   y.ax=@(x)0;
   y.b=@(x)sigma;
   y.bx=@(x)0;

   y.mu=mu;
   y.sigma=sigma;

   y.x0=x0;

   y.ivp=@(x,t)abmpdf(x,t,y);

   %y.stiffness=@(x,dx,n,z)stiffness(x,dx,n,z,y); % default implementation
   y.stiffness=@(x,dx,n,z)auxstiff(x,dx,n,z,y); % specialized implementation

   y.lowBoundary=@nullBoundary;



function y=auxstiff(x,dx,n,z,cf)
   s=cf.sigma;
   m=cf.mu;
   y= -m*jmat(n,z)-(0.5*s*s/dx)*kmat(n,z);
