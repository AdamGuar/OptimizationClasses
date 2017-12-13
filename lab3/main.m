clear all; close all; clc;
%przeprowadzic metode optymalizacji dla 3 wsp a
%kara wewnetrzna
% p =  - 1/g1 - 1/g2 - 1/g3
%dodatkowo if g>0 to p=Inf;
%dodatkowo jezeli mamy wewnetrzna funkcje kary trzeba sprawdzic czy punkt
%startowy znajduje sie w obszarze zabronionym (nie moze byc calego
%simpleksu w obszarze zabronionym
% w metodzie kary wewnetrznej wspolczynnik C maleje
 

x1=linspace(0,6,100);
x2=linspace(0,6,100);
y=zeros(100);
for i=1:100
    for j=1:100
        y(i,j) = fit_fun([x1(i),x2(j)],0,0,0,false);
    end
end
%surf(x1,x2,y);

w_inner=0;
w_outer=0;


alfa=1;
beta=0.5;
gamma=2;
delta=0.5;
epsilon = 1e-4;
Nmax=1e6;
c1=1;
c2=1;
a=[4,4.4934,5];

x1_opt_tab_inner = [];
x1_opt_tab_outer = [];
x2_opt_tab_inner = [];
x2_opt_tab_outer = [];

y_opt_tab_inner = [];
y_opt_tab_outer = [];

w_inner_tab = [];
w_outer_tab = [];

r_inner_tab = [];
r_outer_tab = [];


%sprawdzenie czy punkt startowy jest w obszarze dozwolonym

for i=1:length(a)
  for j=1:100
    
    x0 = 3*rand(2,1)+1;

    while (sqrt(x0(1)^2+x0(2)^2) > a(i));
      x0 = 3*rand(2,1)+1;
    end

    x0_inner = x0;
    x0_outer = x0;

    while true
        [x_opt_inner,y_opt_inner,r_opt_inner,w_inner] = simplex(x0_inner,w_inner,alfa,beta,gamma,delta,epsilon,Nmax,c1,a(i),true)
        if norm(x0_inner-x_opt_inner)<epsilon || w_inner>Nmax
          x1_opt_tab_inner(end+1) = x_opt_inner(1);
          x2_opt_tab_inner(end+1) = x_opt_inner(2);
          y_opt_tab_inner(end+1) = y_opt_inner;
          w_inner_tab(end+1) = w_inner;
          r_inner_tab(end+1) = r_opt_inner;
            break;
        end
        x0_inner=x_opt_inner;
        c1=0.5*c1;
    end
    while true
        [x_opt_outer,y_opt_outer,r_opt_outer,w_outer] = simplex(x0_outer,w_outer,alfa,beta,gamma,delta,epsilon,Nmax,c2,a(i),false)
        if norm(x0_outer-x_opt_outer)<epsilon || w_outer>Nmax
          x1_opt_tab_outer(end+1) = x_opt_outer(1);
          x2_opt_tab_outer(end+1) = x_opt_outer(2);
          y_opt_tab_outer(end+1) = y_opt_outer;
          w_outer_tab(end+1) = w_outer;
          r_outer_tab(end+1) = r_opt_outer;
            break;
        end
        x0_outer=x_opt_outer;
        c2=2*c2;
    end

  end  
end
