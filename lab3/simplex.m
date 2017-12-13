function [x_opt,y_opt,r_opt,w] = simplex(x0,w,alfa,beta,gamma,delta,epsilon,Nmax,c,a,isInnerPenalty)
N=length(x0);
S.x = zeros(N,N+1);
S.y=zeros(1,N+1);
S.x(:,1) = x0;
D=eye(N);
for i=2:N+1
    S.x(:,i) = x0+0.5*D(:,i-1);
end
for i=1:N+1
    [S.y(i),w] = fit_fun(S.x(:,i),w,c,a,isInnerPenalty);
end
while true
    [ignored,xmax] = max(S.y);
    [ignored,xmin] = max(S.y);
    %?
    Xsr.x = mean(S.x(:,[1:xmax-1,xmax+1:end]),2);
    Xodb.x = Xsr.x+alfa*(Xsr.x-S.x(:,xmax));
    [Xodb.y,w] = fit_fun(Xodb.x,w,c,a,isInnerPenalty);
    if Xodb.y>=S.y(xmin) && Xodb.y<S.y(xmax)
       S.x(:,xmax) = Xodb.x;
       S.y(xmax) = Xodb.y;
    elseif Xodb.y<S.y(xmin)
        Xe.x = Xsr.x+gamma*(Xodb.x-Xsr.x);
        [Xe.y,w] = fit_fun(Xe.x,w,c,a,isInnerPenalty);
        if Xe.y >= Xodb.y
            S.x(:,xmax) = Xodb.x;
            S.y(xmax) = Xodb.y;
        else
             S.x(:,xmax) = Xe.x;
             S.y(xmax) = Xe.y;
        end
    else
        Xz.x = Xsr.x+beta*(S.x(:,xmax)-Xsr.x);
        [Xz.y,w] = fit_fun(Xz.x,w,c,a,isInnerPenalty);
        if Xz.y <S.y(xmax)
             S.x(:,xmax) = Xz.x;
             S.y(xmax) = Xz.y;
        else
            for i=[1:xmin-1,xmin+1:N+1]
                S.x(:,i) = delta*(S.x(:,i)+S.x(:,xmin));
                [S.y(i),w] = fit_fun(S.x(:,i),w,c,a,isInnerPenalty);
            end
        end
    end
    A=zeros(1,N+1);
    for i=1:N+1
        A(i) = norm(S.x(:,i)-S.x(:,xmin));
    end;
    if max(A) < epsilon || w>Nmax
        x_opt = S.x(:,xmin);
        y_opt = S.y(xmin);
        r_opt = norm(x_opt);
        return
    end
end
    
    