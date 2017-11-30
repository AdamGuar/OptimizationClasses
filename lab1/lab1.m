clear all; close all; clc;
x=linspace(-100,100,500);
y=zeros(size(x));
for i=1:500
    y(i)=fit_fun(x(i),0);
end
plot(x,y);

x0 = 199*rand-100;
x1=x0+1;
alfa=1.3;
Nmax=1000;
[a,b,w] = expance(x0,x1,alfa,Nmax);

hold on;
plot(a,fit_fun(a,0),'rx','MarkerSize',15);
plot(b,fit_fun(b,0),'kx','MarkerSize',15);

epsilon = 1e-3;

[x_opt,y_opt,w] = lag(a,b,epsilon,1000)
hold on;
plot(x_opt,y_opt,'bo','MarkerSize',10);


  


