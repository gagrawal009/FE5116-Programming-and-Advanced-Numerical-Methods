function v=rmat(r,c)
   persistent m=[ -1/15, -1/5, 1/10;
				 2/15, -4/15, -8/15;
				 -1/15, 7/15, 13/30];
   v = m(r,c);
