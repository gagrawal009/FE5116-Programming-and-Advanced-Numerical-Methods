function p=integratepdf(v, p0, t, mass, stiffness)
   nt=length(t);
   nv=length(v);
   p=zeros(nv,nt);
   p(:,1)=p0;
   w=1/2; % 0=fully implicit

   dtold=0;
   for k=2:nt,
	  dt=t(k)-t(k-1);
	  if (abs(dt-dtold)>1e-10)
		 % if dt has changed, recompute LU factorization
		 Ft=stiffness*dt;
		 A=mass-(1-w)*Ft;
		 [L,U,P,Q]=lu(A); % P A Q = LU, Ax=b, P'LUQ'x=b, LUQ'x=Pb
		 S=mass+w*Ft;
		 dtold=dt;
	  end

	  % compute vector b
	  b=S*p(:,k-1);

	  % solve using the computed LU with permutations
	  Pb=P*b;
	  UQtx=L\Pb;
	  Qtx=U\UQtx;
	  x=Q*Qtx;

	  p(:,k)=max(x,-1e55);
   end




