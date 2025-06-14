function s=simpson(v,p)
   n=length(v);
   w=zeros(1,n);
   i=1;
   while (i<n),
	  w(i:i+2)=w(i:i+2)+[1 4 1]*(v(i+2)-v(i))/6;
	  i=i+2;
   end
   s=w*p;
