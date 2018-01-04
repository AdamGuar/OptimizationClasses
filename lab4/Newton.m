function [d,x0] = Newton(df,H,x0,x_opt)

if ~isempty(x_opt)
    x0 = x_opt;
end

d=-H(x0)^-1*df(x0);