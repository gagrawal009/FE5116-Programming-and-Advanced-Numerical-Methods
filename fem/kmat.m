function v=kmat(r,c)
   persistent m=[ 7/3, -8/3, 1/3;
				 -8/3, 16/3, -8/3;
				 1/3, -8/3,  7/3];
   v = m(r,c);
