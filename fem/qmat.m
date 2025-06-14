function v=qmat(r,c)
   persistent m=[ 1/2, -2/3, 1/6;
				  -2/3, 8/3, -2;
				  1/6, -2, 11/6];
   v = m(r,c);
