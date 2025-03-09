h=0.25

x=1 + (0:1:6)*h

f=@(x)sqrt(5*x.^2+1)

n = length(x)

f_values = arrayfun(f,x)

%init with zeros
finite_diff_table=zeros(n, n)

%put on the first row the init values
finite_diff_table(:,1) = f_values

for j=2:n
    for i=1:n-j+1
        finite_diff_table(i,j) = finite_diff_table(i+1,j-1) - finite_diff_table(i,j-1)
    end
end

disp("finite difference table")
disp(array2table(finite_diff_table))

