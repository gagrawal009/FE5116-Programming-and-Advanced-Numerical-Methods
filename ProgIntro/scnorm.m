% implement the standard cumulative normal function using erfc
% (see erf on wikipedia)
% this is just for illusration, Matlab offer the function cdfnorm
function y=scnorm(x)
   y = 0.5 * erfc( -x / sqrt(2) );
end

