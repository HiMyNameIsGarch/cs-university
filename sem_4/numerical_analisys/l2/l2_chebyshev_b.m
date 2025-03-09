%domain
x=-1:0.01:1;

n=3
% base cases
T0=ones(size(x));
T1=x;

figure;
plot(x,T0);hold on;
plot(x,T1);

for k=2:n
    Tk = 2*x.*T1-T0
    plot(x,Tk)
    
    T0 = T1
    T1 = Tk
end


