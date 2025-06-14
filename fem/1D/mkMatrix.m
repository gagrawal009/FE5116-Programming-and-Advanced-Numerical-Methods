function y=mkMatrix(f,v)
  np=length(v);
  assert(mod(np,2));
  nElem=(np-1)/2;
  nEq=np;

  bufsz = nElem * 3*3; % pre-allocate memory

  ii=zeros(bufsz,1);
  jj=zeros(bufsz,1);
  vv=zeros(bufsz,1);

  k=0;

  for c=0:nElem-1; % c style index
	 c2=c*2;
	 vc=v(idx(c2));
	 dvc=v(idx(c2+2))-vc;
	 for n=0:2,    % c style index
		for z=0:2, % c style index
		   k=k+1;
		   ii(k)=idx(c2+z);
		   jj(k)=idx(c2+n);
		   %[n,z],
		   vv(k)=f(vc,dvc,idx(n),idx(z));
		end
	 end
  end

  assert(k==bufsz);

  y=sparse(ii,jj,vv,nEq,nEq);



function matlabindex=idx(cindex)
  matlabindex=cindex+1;
