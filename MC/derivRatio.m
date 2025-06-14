function yp = derivRatio( f, x, h, hLeftFact, hRightFact )
   xm = x + h * hLeftFact;%use h = 1 for safety as input and adjust hleft h right
   xp = x + h * hRightFact;
   hs = xp-xm;
   yp = (f(xp)-f(xm)) ./ hs;
   yp(isnan(yp)) = 0.0;
end
