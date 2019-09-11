%10
function [val]=fib(n)
    if(n==2)
        val=ones(1,n);
        return
    end
    tmp=fib(n-1)
    val=[tmp tmp(n-2)+tmp(n-1)]
end