x=[2 4 6 8]
f=[4 8 14 16]
n=length(x)
divided_diff_table=zeros(n,n)
divided_diff_table(:,1)=f';

for j=2:n
    for i = 1:n-j+1
        divided_diff_table(i,j)=(divided_diff_table(i+1,j-1)-divided_diff_table(i,j-1))/(x(i+j-1)-x(i))
    end
end
disp("Divided difference table")
disp(array2table(divided_diff_table))