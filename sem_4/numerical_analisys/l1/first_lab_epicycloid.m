t = 0:0.01*pi:10*pi
a = 2
b = 3
xt = (a + b)*cos(t) - b*cos((a\b+1)*t)
yt = (a + b)*sin(t) - b*sin((a\b+1)*t)
plot(xt,yt)
title('epicycloid')