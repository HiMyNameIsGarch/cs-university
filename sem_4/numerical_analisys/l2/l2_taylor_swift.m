x=-1:0.01:3;
x0=0;

n=50;

f=exp(x);

figure;
hold on;

plot(x,f)

for k=0:n
    Pn=zeros(size(x))
    
    for m=0:k
        Pn = Pn + (x - x0).^m / factorial(m);
    end
    
    plot(x, Pn)
end
