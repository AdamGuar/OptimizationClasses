function [a,b] = wyznacz_ab(x_opt,d,N,xmin,xmax)

a=zeros(N,1);
b=zeros(N,1);

for i=1:N
    if d(i)==0
        a(i) = -Inf;
        b(i) = Inf;
    elseif d(i) > 0
            a(i) = (xmin(i)-x_opt(i))/d(i);
            b(i) = (xmax(i)-x_opt(i))/d(i);
    else
        
            a(i) = (xmax(i)-x_opt(i))/d(i);
            b(i) = (xmin(i)-x_opt(i))/d(i);
    end
end

a=max(a);
b=min(b);

