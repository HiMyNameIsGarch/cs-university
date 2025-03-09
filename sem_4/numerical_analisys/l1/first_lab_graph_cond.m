x1=-1:0.01:0
f1 = x1.^3 + sqrt(1-x1)
x2=0:0.01:1
f2 = x2.^3 + sqrt(1-x2)
plot(x1, f1,x2,f2)
title('my func')