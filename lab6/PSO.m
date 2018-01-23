function [x_opt, y_opt, W] = PSO(epsilon, Nmax, xmin,xmax)

W=0; % l.w.f.c
N=2; %wymiar problemu
C=20; %liczba czastek
w=0.8 %wsp. bezwladnosci czastek
c1 = 1;
c2 = 2; %wsp przyspieszenia

R.x = zeros(N,C);
R.v = zeros(N,C);
R.y = zeros(1,C);

for i=1:C
      R.x(:,i)=(xmax-xmin).*rand(N,1)+xmin;
      R.v(:,i)=0.002*(xmax-xmin).*rand(N,1)-0.001*(xmax-xmin);
      [R.y(i),W] = fit_fun(R.x(:,i),W);
end

x_opt_i = R.x
y_opt_i = R.y;

[y_opt,numer] = min(R.y);
x_opt=R.x(:,numer);

while true
    for i=1:C
        R.v(:,i) = w*R.v(:,i)+c1*rand*(x_opt-R.x(:,i))+...
            c2*rand*(x_opt_i(:,i)-R.x(:,i));
        R.x(:,i) = R.x(:,i)+R.v(:,i);
        [R.y(i),W] = fit_fun(R.x(:,i),W);
        if R.y(i) < y_opt
            y_opt = R.y(i);
            x_opt = R.x(:,i);
            if y_opt < epsilon
                return;
            end
        end
        
        if R.y(i) < y_opt_i(i)
            y_opt_i(i) = R.y(i);
            x_opt_i(:,i) = R.x(:,i);
        end
        if W>Nmax
            return;
        end
    end
end

function [y,W] = fit_fun(x,W)

W=W+1;
%y=x(1)^2 + x(2)^2;

m1=400;
m2=50;
k1=x(1); %wsp sprezystosci resoroqw
k2=2e5;
b=x(2);
g=9.81;
x2_0 = -(m1+m2)*g/k2;
x1_0 = - m1*g/k1+x2_0;
T=5;
dt=0.01;
A=0.06;
f=2*pi*10;
 

%eksport zmiennych do workspace bazowego
assignin('base','m1', m1);
assignin('base','m2', m2);
assignin('base','k1', k1);
assignin('base','k2', k2);
assignin('base','b', b);
assignin('base','g', g);
assignin('base','x1_0', x1_0);
assignin('base','x2_0', x2_0);
assignin('base','T', T);
assignin('base','dt', dt);
assignin('base','A', A);
assignin('base','f', f);

sim('model.mdl');

y=0; % //TODO obliczenie wartosci funkcji celu na podstawie x1


%wartosc kary
p = max(0,-k1)^2 + max(0,k1-2e4)^2+...
    max(0, -b)^2 + max(0,b-3e3)^2+...
    max(0, -x1_0-0.3)^2;

y=y+1.e6*p;

plot(t,x1);

%filtr 12 rzedu, 2* czestotliwosc odciecia / czestotliwosc probkowania
[l,m] = butter(12, 2 * 8 / 100, 'low');

x1_f = filter(l,m,x1);

figure
plot(t,x1_f);

error('Na razie tyle liczenia');


