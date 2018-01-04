clear all; close all; clc;
%x=sym('x',[2,1]);
%f=(x(1)+2*x(2)-7)^2+(2*x(1)+x(2)-5)^2;
%df = gradient(f);
%H=hessian(f);

f= @(x)(x(1)+2*x(2)-7)^2+(2*x(1)+x(2)-5)^2;

df = @(x) [10*x(1)+8*x(2)-34;
    8*x(1)+10*x(2)-38];

H = @(x)[10,8;
    8,10];

xmin=[-10;-10];
xmax=[10;10];

%x0=(xmax-xmin).*rand(2,1)+xmin;

epsilon=1e-3;
delta=1e-6;
Nmax=1e3;

h=0.05;
x_opt=[];
d=[];
w=0;

i=1;

x1_opt_vec = [];
x2_opt_vec = [];
y_opt_vec = [];
lwfc_vec = [];
lit_vec = [];
x0_1_vec = [];
x0_2_vec = [];


for j=1:100
  x0=(xmax-xmin).*rand(2,1)+xmin;
  x0_global = x0;
  for k=1:3
    if k==1
      h=0.05;
    end
    if k==2
      h=0.12;
    end
    if k==3
      h=1;
    end
    d=[];
    i=1;
    w=0;
    x0_1_vec(end+1) = x0_global(1);
    x0_2_vec(end+1) = x0_global(2);
    while true
        [d,x0] = naj_spadek(df,x0,x_opt);
       %[d,x0] = grad_sprz(df,x0,x_opt,d);
       %[d,x0] = Newton(df,H,x0,x_opt);
       
       g=@(h)f(x0+h*d);
       b=wyznacz_b(x0,d,xmin,xmax);
       if k == 3 
         [h,w] = zloty2(0,b,w,epsilon,Nmax,g);
       end
       
        x_opt=x0+h*d;
        if norm(x0-x_opt) < epsilon || i>Nmax || norm(df(x_opt)) < delta
            break
        end
        i=i+1;
    end
    x1_opt_vec(end+1) = x_opt(1);
    x2_opt_vec(end+1) = x_opt(2);
    y_opt_vec(end+1) = f(x_opt);
    x_opt=[];
    lit_vec(end+1) = i;
    i=1;
    x0 = x0_global;
    d=[];
    lwfc_vec(end+1) = w;
    w=0;
    while true
        %[d,x0] = naj_spadek(df,x0,x_opt);
       [d,x0] = grad_sprz(df,x0,x_opt,d);
       %[d,x0] = Newton(df,H,x0,x_opt);
       
       g=@(h)f(x0+h*d);
       b=wyznacz_b(x0,d,xmin,xmax);
       if k == 3 
         [h,w] = zloty2(0,b,w,epsilon,Nmax,g);
       end
       
        x_opt=x0+h*d;
        if norm(x0-x_opt) < epsilon || i>Nmax || norm(df(x_opt)) < delta
            break
        end
        i=i+1;
    end
    x1_opt_vec(end+1) = x_opt(1);
    x2_opt_vec(end+1) = x_opt(2);
    y_opt_vec(end+1) = f(x_opt);
    x_opt=[];
    lit_vec(end+1) = i;
    lwfc_vec(end+1) = w;
    i=1;
    x0 = x0_global;
    d=[];
    w=0;
    while true
        %[d,x0] = naj_spadek(df,x0,x_opt);
       %[d,x0] = grad_sprz(df,x0,x_opt,d);
       [d,x0] = Newton(df,H,x0,x_opt);
       
       g=@(h)f(x0+h*d);
       b=wyznacz_b(x0,d,xmin,xmax);
       if k == 3 
         [h,w] = zloty2(0,b,w,epsilon,Nmax,g);
       end
       
        x_opt=x0+h*d;
        if norm(x0-x_opt) < epsilon || i>Nmax || norm(df(x_opt)) < delta
            break
        end
        i=i+1;
    end
    x1_opt_vec(end+1) = x_opt(1);
    x2_opt_vec(end+1) = x_opt(2);
    y_opt_vec(end+1) = f(x_opt);
    x_opt=[];
    lit_vec(end+1) = i;
    lwfc_vec(end+1) = w;
    i=1;
    x0 = x0_global;
    d=[];
    w=0;
  end
  d=[];
  w=0;
  i=1;
  x_opt=[];
  x0 = x0_global;
end
%disp(x_opt);
csvwrite('x0_1_vec.xls',x0_1_vec);
csvwrite('x0_2_vec.xls',x0_2_vec);
csvwrite('x1_opt_vec.xls',x1_opt_vec);
csvwrite('x2_opt_vec.xls',x2_opt_vec);
csvwrite('y_opt_vec.xls',y_opt_vec);
csvwrite('lwfc_vec.xls',lwfc_vec);
csvwrite('lit_vec.xls',lit_vec);


