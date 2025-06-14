function y=gbmpdf(x,t,cf)
   s=cf.sigma;
   m=cf.mu;
   x0=cf.x0;
   y=lognpdf(x, log(x0)+(m-0.5*s^2)*t,s*sqrt(t));
   y(find(isnan(y)))=0;
   y(find(isinf(y)))=0;
