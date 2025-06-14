% This is a script file, not a function file

% Using the synthax for 'anonymous functions'
% this command define the function f(x,y)=x^2+y^3
f = @(x,y) x^2+y^3;

% Suppose we want to transform f(x,y) into a function of
% just one variable where the argument y is const-folded
% to y=3, i.e. we want g(x)=f(x,3)

g = @(x) f(x,3);


% Let's look at what we defined in memory
who

% Let's try to compute g(2)
g(2)