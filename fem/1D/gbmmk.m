function y=gbmmk(x0,mu,sigma)
   y.a=@(x)mu*x;
   y.ax=@(x)mu;
   y.b=@(x)sigma*x;
   y.bx=@(x)sigma;

   y.mu=mu;
   y.sigma=sigma;

   y.x0=x0;

   y.ivp=@(x,t)gbmpdf(x,t,y);

   %y.stiffness=@(x,dx,n,z)stiffness(x,dx,n,z,y); % default implementation
   y.stiffness=@(x,dx,n,z)auxstiff(x,dx,n,z,y); % specialized implementation

   y.lowBoundary=@nullBoundary;


function y=auxstiff(x,dx,n,z,cf)
   s=cf.sigma;
   m=cf.mu;
   y1=m*(dx*(imat(n,z)+rmat(n,z))+x*jmat(n,z));
   y2=s^2*( x*jmat(z,n)+dx*rmat(z,n)+x^2/(2*dx)*kmat(n,z)+x*qmat(n,z)+dx/2*smat(n,z));
   y=-y1-y2;
