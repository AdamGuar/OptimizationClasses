function [a,b,w]=expance(x0,x1,alfa,Nmax)

w=0;
X0.x=x0;
[X0.y,w]=fit_fun(x0,w);
X1.x=x1;
[X1.y,w]=fit_fun(x1,w);
if X0.y==X1.y
    a=X0.x;
    b=X1.x;
    return
end
if X1.y>X0.y
    X1.x=2*X0.x-X1.x;
    x1=2*x0-x1;
    [X1.y,w]=fit_fun(X1.x,w);
    
    if X1.y>X0.y
        a=X1.x;
        b=2*X0.x-X1.x;
        return
    end
end
i=1;
while i<=Nmax
    X2.x = x0 + alfa^i*(x1-x0);
    [X2.y,w] = fit_fun(X2.x,w);    
    if X2.y >= X1.y
        break;
    end
    X0=X1;
    X1=X2;
    i=i+1
end
a=min([X0.x,X2.x]);
b=max([X0.x,X2.x]);

    

