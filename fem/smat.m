function v=smat(r,c)
   persistent m=[ 1/5, -2/5, 1/5;
				 -2/5, 32/15, -26/15;
				 1/5, -26/15,  23/15];
   v = m(r,c);
