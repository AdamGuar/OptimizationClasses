function [h,w] = zloty(a,b,w,epsilon,Nmax,g)

alfa = (5^0.5-1)/2;

A.x =a;
A.y=NaN;
B.x = b;
B.y=NaN;

C.x= B.x-alfa*(B.x-A.x);
[C.y,w] = fit_fun(C.x,w,g);
D.x = A.x+alfa*(B.x-A.x);
[D.y,w] = fit_fun(D.x,w,g);
while true
    if C.y < D.y
        B=D;
        C=C;
        C.x= B.x-alfa*(B.x-A.x);
        [C.y,w] = fit_fun(C.x,w,g);
    else
        A=C;
        C=D;
        D.x = A.x+alfa*(B.x-A.x);
        [D.y,w] = fit_fun(D.x,w,g);
    end
    if B.x-A.x<epsilon || w > Nmax
        h=(A.x+B.x)/2;
        return;
    end
end
        
        

function [y,w] = fit_fun(x,w,g)
w=w+1;
y=g(x);