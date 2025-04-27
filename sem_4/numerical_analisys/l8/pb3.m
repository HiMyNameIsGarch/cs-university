r = 110;
p = 75;

f = @(x) sqrt(1-(p/r)^2*sin(x));

a = 0 ;
b = 2*pi;

n_val =[2,3,4,5,6,7,8];

for n = n_val
    h=(b-a)/n;

    x = a+h*(0:n);

    integral = (h/2)*(f(a)+f(b)) + h*sum(f(x(2:end-1)));

    H = (60*r/(r^2-p^2))*integral;

    fprintf("\nFor n = %d, H = %f", n,H);
end
