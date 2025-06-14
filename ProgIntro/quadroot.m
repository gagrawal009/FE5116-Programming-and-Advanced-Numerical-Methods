% find the roots of a quadratic equation in the form
% a x^2 + b x + c = 0
function x = quadroot(a, b, c)
   delta = b^2 - 4*a*c;
   sdelta = sqrt(delta);
   twoa = 2*a;
   x1 = (-b + sdelta)/twoa;
   x2 = (-b - sdelta)/twoa;
   x=[x1,x2];
end
