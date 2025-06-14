function y=stiffness(x,dx,n,z,cf)
   y=quadgk(@(u)f(x,dx,n,z,cf,u),0,1);


function y=f(x0,dx,n,z,cf,u)
   [b,db]=mkBasis();

   x=x0+u*dx;

   psin=b{n}(u);
   zetan=db{n}(u);
   psiz=b{z}(u);
   zetaz=db{z}(u);

   a=cf.a(x);
   ax=cf.ax(x);
   b=cf.b(x);
   bx=cf.bx(x);

   d1= dx * ax .* psin;
   d2= a .* zetan;
   d3= b .* bx .* psin;
   d4= b .* b .* zetan / (2*dx);
   y = -(d1+d2) .* psiz - (d3+d4) .* zetaz;

