function [y,w] = fit_fun(x,w)
w=w+1;
y=-cos(0.1*x)*exp(-(0.1*x-2*pi)^2)+0.002*(0.1*x)^2;