clear all; close all; clc;

%f1=@(x)(x(1)+1)^2+(x(2)+1)^2;
%f2=@(x)(x(1)-1)^2+(x(2)-1)^2;

%xmin=[-10;-10];
%xmax = [10;10];

ro = 7800;
P = 1e3;
E=207e9;
f2max = 5e-3;
sigmamax = 300e6;

f1=@(x)0.25*x(1)*pi*x(2)^2*ro;
f2=@(x)(64*P*x(1)^3)/(3*E*pi*x(2)^4);
sigma=@(x)(32*P*x(1))/(pi*x(2)^3);

xmin=[200;10]*1e-3;
xmax=[1000;50]*1e-3;

minf1 = f1(xmin);
maxf1 = f1(xmax);
minf2 = f2([xmin(1);xmax(2)]);
maxf2 = f2([xmax(1);xmin(2)]);

f1n=@(x)(f1(x)-minf1)/(maxf1-minf1);
f2n=@(x)(f2(x)-minf2)/(maxf2-minf2);


epsilon =1e-3;
Nmax=1e3;


N=2;
wagi=0:0.01:1;
X_OPT = zeros(N,length(wagi));
Y_OPT = zeros(2,length(wagi));
lit = 0;
lit_vec = [];

x0_1_vec = [];
x0_2_vec = [];
w_vec = [];

for i=1:length(wagi)
    while true
        x0=(xmax-xmin).*rand(N,1)+xmin;
        p =(max(0,f2(x0)-f2max)^2+max(0,sigma(x0)-sigmamax)^2);
        if p== 0
            break
        end
    end
    x0_1_vec(end+1) = x0(1);
    x0_2_vec(end+1) = x0(2);
    W=wagi(i);
    F=@(x)W*f1n(x) + (1-W)*f2n(x)+...
        1e6*(max(0,f2(x)-f2max)^2+max(0,sigma(x)-sigmamax)^2);
    [x_opt,w,lit] = Powell(x0,N,F,epsilon,Nmax,xmin,xmax);
    lit_vec(end+1) = lit;
    w_vec(end+1) = w;
    X_OPT(:,i)=x_opt;
    Y_OPT(:,i)=[f1(x_opt);f2(x_opt)];
end

csvwrite('lit.csv',lit_vec);
csvwrite('lwfc.csv',w_vec);
csvwrite('x01.csv',x0_1_vec);
csvwrite('x02.csv',x0_2_vec);
csvwrite('dlugosc-srednica.csv',X_OPT);
csvwrite('masa-ugiecie.csv',Y_OPT);

plot(Y_OPT(1,:),Y_OPT(2,:),'rx','MarkerSize',10);