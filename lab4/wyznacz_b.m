function b=wyznacz_b(x0,d,xmin,xmax)
b=zeros(length(x0),1);

for i=1:length(x0)
    if d(i) == 0
        b(i)=Inf;
    elseif d(i)>0
        b(i)=(xmax(i)-x0(i))/d(i);
    else
        b(i)=(xmin(i)-x0(i))/d(i);
    end
end

b = min(b);
