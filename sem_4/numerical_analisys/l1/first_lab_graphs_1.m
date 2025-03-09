x = 0:0.01:1;
f1 = exp(10*x.*(x-1)).*sin(12*pi*x)
f2 = 3*exp(5*x.^2-1).*cos(12*pi*x)
plot(x,f1,x,f2)
title('problem 1')
