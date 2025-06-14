function y=mkXGrid(xmi,xma,nelem)
   sz=(xma-xmi)/nelem;
   dx=sz/2;
   y=dx*[0:2*nelem]+xmi;
