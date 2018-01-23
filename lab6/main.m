clear all; close all; clc;

m1 = 400;
m2 = 50;
k1=2e4;
k2=2e5;
b=2e3;
g=9.81;

x2_0 = -(m1+m2)*g/k2;
x1_0 = -m1*g/k1 +x2_0;

T=5;
dt=1e-2;

f=2*pi*25;
A=0.06;

sim('model.mdl');

subplot(3,1,1);
plot(t,x1);
subplot(3,1,2);
plot(t,x2);
subplot(3,1,3);
plot(t,xp);