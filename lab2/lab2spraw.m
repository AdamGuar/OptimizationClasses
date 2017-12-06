clear all; close all; clc;

expanceIndicators = [1.000789,1.5000094,1.90008776];
Nmax=1000;
epsilon = 1e-3;

x_opt_lag_vec = [];
y_opt_lag_vec = [];

x_opt_fib_vec = [];
y_opt_fib_vec = [];


w_exp_vec = [];
w_fib_vec = [];
w_lag_vec = [];


x0_vec = [];
a_vec = [];
b_vec = [];
 


for e=expanceIndicators
  for i=1:100
    x0 = 199*rand-100;
    
    x0_vec(end+1) = x0;
    
    x1=x0+1;
    [a,b,w] = expance(x0,x1,e,Nmax);
    
    a_vec(end+1) = a;
    b_vec(end+1) = b;
    
    w_exp_vec(end+1) = w;
    
    [x_opt_lag,y_opt_lag,w_lag] = lag(a,b,epsilon,1000);
    
    x_opt_lag_vec(end+1) = x_opt_lag;
    y_opt_lag_vec(end+1) = y_opt_lag;
    w_lag_vec(end+1) = w_lag;
    
    [x_opt_fib,y_opt_fib,w_fib] = fib(a,b,epsilon);
    
    x_opt_fib_vec(end+1) = x_opt_fib;
    y_opt_fib_vec(end+1) = y_opt_fib;
    w_fib_vec(end+1) = w_fib;
    
    end
end

    
    

    