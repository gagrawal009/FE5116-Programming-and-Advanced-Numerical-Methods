function y=cirpdf(x,t,model)
   ltmean=model.theta;
   x0=model.x0;
   s2=model.sigma*model.sigma;
   kappa=model.kappa;
   ek=exp(-kappa*t);
   c=(1-ek)*s2/(4*kappa);
   k=4*kappa*ltmean/s2;
   l=x0*ek/c;
   y=ncx2pdf(x/c, k, l)/c;
   y(find(isnan(y)))=0;
   y(find(isinf(y)))=0;


