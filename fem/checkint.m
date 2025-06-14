function res=checkint()
  [b,db]=mkBasis();

  res=[];
  f=@(i,j,x) b{i}(x) .* b{j}(x);
  res=[res;checkfun('i',f,@imat)];

  f=@(i,j,x) db{i}(x) .* b{j}(x);
  res=[res;checkfun('j',f,@jmat)];

  f=@(i,j,x) db{i}(x) .* db{j}(x);
  res=[res;checkfun('k',f,@kmat)];

  f=@(i,j,x) x .* db{i}(x) .* db{j}(x);
  res=[res;checkfun('q',f,@qmat)];

  f=@(i,j,x) x .* db{i}(x) .* b{j}(x);
  res=[res;checkfun('r',f,@rmat)];

  f=@(i,j,x) x .* x .* db{i}(x) .* db{j}(x);
  res=[res;checkfun('s',f,@smat)];

  f=@(i,j,x) x .* b{i}(x) .* b{j}(x);
  res=[res;checkfun('g',f,@gmat)];




function res=checkfun(name,f,g)
   ['checking: ', name],
   res=[];
   for i=1:3,
	  for j=1:3,
		 h=@(x) f(i,j,x);
		 n=quadgk(h,0,1,1e-6);
		 s=g(i,j);
		 if (abs(s-n)>1e-5)
			res=[res; [name,' ', num2str(i-1),' ',num2str(j-1),' s=',num2str(s),' n=',num2str(n)]
				];
		 end
	  end
   end




