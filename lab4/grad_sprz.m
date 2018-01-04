function [d,x0] = grad_sprz(df,x0,x_opt,d)

if isempty(x_opt)
    d=-df(x0);
else
    beta = norm(df(x_opt))^2/norm(df(x0))^2;
    d = -df(x_opt) + beta * d;
    x0=x_opt;
end