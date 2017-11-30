function [x_opt,y_opt,w] = fib(a,b,epsilon)
w=0;
F=[1;1];
k=2;
while F(k)<(b-a)/epsilon
    F(k+1)=F(k-1)+F(k);
    k=k+1;
end
F(k+1)=F(k-1)+F(k);
k=k+1;

A.x=a;
A.y=NaN;
B.x=b;
B.y=NaN;

C.x=B.x-F(k-1)/F(k)*(B.x-A.x);
[C.y,w] = fit_fun(C.x,w);
D.x = A.x + B.x - C.x;
[D.y,w] = fit_fun(D.x,w);
for i=1:k-3
    if C.y<D.y
        B = D;
    else
        A = C;
    end
   C.x=B.x-F(k-1)/F(k)*(B.x-A.x);
   [C.y,w] = fit_fun(C.x,w);
   D.x = A.x + B.x - C.x;
   [D.y,w] = fit_fun(D.x,w);
end
x_opt = C.x;
y_opt = C.y;



