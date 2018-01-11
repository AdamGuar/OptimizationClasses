function [y,w] = fit_fun(x,w,c,a)
w=w+1;

y=sin(pi*((x(1)/pi)^2+(x(2)/pi)^2)^0.5)/(pi*((x(1)/pi)^2+(x(2)/pi)^2)^0.5);

%kara zewnetrzna
p=max(0,-x(1)+1)^2+max(0,-x(2)+1)^2+max(0,(x(1)^2+x(2)^2)^0.5-a)^2;
y=y+c*p;


