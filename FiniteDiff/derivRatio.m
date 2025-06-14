function yp = derivRatio( f, x, h, hLeftFact, hRightFact )
   xm = x + h * hLeftFact;
   xp = x + h * hRightFact;
   hs = xp-xm;
   yp = (f(xp)-f(xm)) ./ hs;
   yp(isnan(yp)) = 0.0;
end

