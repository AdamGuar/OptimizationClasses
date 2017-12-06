function [x_opt,y_opt,w] = Rosen (x0,s0,alfa,beta,epsilon,Nmax)
w=0;
X.x = x0;
p = zeros(size(x0));
l = zeros(size(x0));
s = s0*ones(size(x0));

D = eye(length(x0));

[X.y,w] = fit_fun(X.x,w);

while true
    for i=1:length(X.x)
        Xt.x = X.x + s(i) * D(:,i);
        [Xt.y,w] = fit_fun(Xt.x,w);
        if(Xt.y < X.y)
            X=Xt;
            l(i) = l(1) + s(i);
            s(i) = alfa * s(i);
        else
            p(i) = p(i) + 1;
            s(i) = -beta*s(i);
        end
    end
    if all(p~=0) && all(l~=0)
        L = zeros(length(X.x));
        for i=1:length(X.x)
            L(i:end,i) = l(i:end);
        end
        Q = D *L;
        v=Q(:,1);
        D(:,1) = v/norm(v);
        for i=2:length(X.x);
            T = 0;
            for j=1:i-1
                T=T+Q(:,1).'*D(:,j)*D(:,j);
            end
            v=Q(:,i)-T;
            D(:,i)=v/norm(v);
        end
        p = zeros(size(X.x));
        l = zeros(size(X.x));
        s = s0*ones(size(X.x));
    end
    if(abs(max(s))<epsilon || w > Nmax)
        x_opt = X.x;
        y_opt = X.y;
        return 
    end
end
