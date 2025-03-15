x=0:0.01:2*pi
f1=cos(x)
f2=sin(x)
f3=cos(2*x)
plot(x,f1,x,f2,x,f3)
saveas(gcf, 'sine_wave.png');
