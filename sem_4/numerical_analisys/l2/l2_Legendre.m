x=0:0.01:1

subplot(2,2,1)
L1=[1 0]
plot(x, polyval(L1,x))

subplot(2,2,2)
L2=[3/2 0 -1/2]
plot(x, polyval(L2,x))

subplot(2,2,3)
L3=[5/2 0 -3/2 0]
plot(x, polyval(L3,x))

subplot(2,2,4)
L4=[35/8 0 -15/4 0 3/8]
plot(x, polyval(L4,x))

