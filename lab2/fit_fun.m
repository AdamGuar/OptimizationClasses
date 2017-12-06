function [y,w] = fit_fun(x,w)
w=w+1;
y=x(1)^2+x(2)^2-cos(2.5*pi*x(1))-cos(2.5*pi*x(2))+2;
