function p=abmpdf(x,t,cf)
   m=cf.x0+cf.mu*t;
   sv=cf.sigma*sqrt(t);
   p=normpdf(x,m,sv);
