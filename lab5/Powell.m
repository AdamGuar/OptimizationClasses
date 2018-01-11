function [x_opt,w,lit] = Powell(x0,N,F,epsilon,Nmax,xmin,xmax)

w=0;
D=eye(N);
lit=0;
while true
    x_opt = x0;
    for i=1:N
        g=@(h)F(x_opt+h*D(:,i));
        [a,b] = wyznacz_ab(x_opt,D(:,i),N,xmin,xmax);
        [h,w]=zloty2(a,b,w,epsilon,Nmax,g);
        x_opt = x_opt+h*D(:,i);
    end
    for i=1:N-1
        D(:,i) = D(:,i+1);
    end
    D(:,N)=x_opt-x0;
    g=@(h)F(x_opt+h*D(:,N));
    [a,b] = wyznacz_ab(x_opt,D(:,N),N,xmin,xmax);
    [h,w]=zloty2(a,b,w,epsilon,Nmax,g);
    x_opt = x_opt+h*D(:,N);
    lit = lit +1;
    if norm(x_opt-x0)<epsilon || w>Nmax
        return;
    end
    x0 = x_opt;
end