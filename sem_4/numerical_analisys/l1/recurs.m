function f = recurs(n)
if n<=1
    f = 1 + 1/(1+1);
    
else
    f = 1 + (1 / (recurs(n-1)));
end
end
