function v=jmat(r,c)
   persistent m=[ -1/2, -2/3, 1/6;
				  2/3,   0, -2/3;
				  -1/6, 2/3, 1/2];
   v = m(r,c);
