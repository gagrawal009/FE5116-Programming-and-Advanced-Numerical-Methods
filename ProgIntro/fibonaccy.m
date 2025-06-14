function y = fibonaccy(n)
    if n == 0
        y = 0;  % Fibonacci(0) = 0
    elseif n == 1
        y = 1;  % Fibonacci(1) = 1
    else
        y = fibonaccy(n - 1) + fibonaccy(n - 2);  % Fibonacci(n) = Fibonacci(n-1) + Fibonacci(n-2)
    end
end
