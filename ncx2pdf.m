function y=ncx2pdf(x,k,l)
   % k: degrees of freedom
   % l: non central parameter
   et=1/2 *exp(-(x+l)/2);
   pt=(x/l).^(k/4-1/2);
   bt=besseli(k/2-1,sqrt(l*x));
   y= et .* pt .* bt;
