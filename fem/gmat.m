function v=gmat(r,c)
   persistent m=[ 1/60, 0, -1/60;
				  0, 4/15, 1/15;
				 -1/60, 1/15,  7/60];
   v = m(r,c);
