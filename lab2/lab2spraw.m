clear all; close all; clc;

stepsArr = [0.15,0.45,0.65];
Nmax=1000;
epsilon = 1e-3;
beta=0.5;

x_opt_HJ_vec = {};
y_opt_HJ_vec = [];

x_opt_ros_vec = {};
y_opt_ros_vec = [];


w_HJ_vec = [];
w_ros_vec = [];


x0_vec = {};


alfaHJ=0.5;
alfaROSEN=2;
 

for e=stepsArr
  for i=1:100
    x0 = 2*rand(2,1)-1;
    
    x0_vec(end+1) = x0;
    
    x1=x0+1;
    
    [x_opt_HJ,y_opt_HJ,w_HJ] = HJ(x0,e,alfaHJ,epsilon,Nmax)
    
    x_opt_HJ_vec(end+1) = x_opt_HJ;
    y_opt_HJ_vec(end+1) = y_opt_HJ;
    w_HJ_vec(end+1) = w_HJ;
    
    [x_opt_ros,y_opt_ros,w_ros] = Rosen (x0,e,alfaROSEN,beta,epsilon,Nmax)
    
    x_opt_ros_vec(end+1) = x_opt_ros;
    y_opt_ros_vec(end+1) = y_opt_ros;
    w_ros_vec(end+1) = w_ros;
    
    end
end

    
    

    