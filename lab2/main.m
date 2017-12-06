clear all; close all; clc;

x1 = linspace(-1,1,100);
x2 = x1;
y= zeros(100);
for i=1:100
    for j=1:100
        y(i,j) = fit_fun([x1(i);x2(j)],0);
    end
end

contour(x1,x2,y);

x0 = 2*rand(2,1)-1;
s0=0.25;
% W HJ alfa odpowiada za skracanie kroku dlatego <1 w Rosen odpowiada za
% wydluzanie kroku wiec >1;
alfa=2;
beta=0.5;
epsilon =1e-3;
Nmax =1e3;

[x_opt,y_opt,w] = Rosen (x0,s0,alfa,beta,epsilon,Nmax)

hold on;
plot(x0(1),x0(2),'r*','MarkerSize',15);

plot(x_opt(1),x_opt(2),'k*','MarkerSize',15);

% SPRAWKOOOOO:
% Narysowaæ progresjê punkty rowi¹zania dla obydwu metod, w przypadku HJ
% bêdzie to punkt bazowy