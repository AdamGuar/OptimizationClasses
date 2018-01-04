function [d,x0] = naj_spadek(df,x0,x_opt)

if ~isempty(x_opt)
    x0=x_opt;
end
d=-df(x0);