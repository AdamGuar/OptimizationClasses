function [x_opt,y_opt,w] = lag(a,b,epsilon,Nmax)
w=0;
A.x = a;
[A.y,w] = fit_fun(A.x,w);
B.x = b;
[B.y,w] = fit_fun(B.x,w);
C.x = (A.x+B.x)/2;
[C.y,w] = fit_fun(C.x,w);
i=1;
while i<Nmax
    p=polyfit([A.x,C.x,B.x],[A.y,C.y,B.y],2);
    D.x = -p(2)/(2*p(1));
    [D.y,w] = fit_fun(D.x,w);
    if D.x<C.x
        if D.y < C.y
            B=C;
            C=D;
        else
            A=D
        end
    else
        if D.y < C.y
            A = C;
            C = D;
        else
            B = D;
        end
    end
   if(B.x-A.x)<epsilon
       x_opt=C.x;
       y_opt=C.y;
       return;
   end
   i=i+1;
end
x_opt=NaN;
y_opt=NaN;
            

