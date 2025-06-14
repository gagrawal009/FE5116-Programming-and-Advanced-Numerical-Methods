function v=imat(r,c)
   persistent m=[ 2/15, +1/15, -1/30;
				 1/15, 8/15, +1/15;
				 -1/30, +1/15, 2/15];
   v = m(r,c);
