function [x_opt,y_opt,w] = HJ(x0,s0,alfa,epsilon,Nmax)
w=0;
XB.x = x0;
[XB.y,w] = fit_fun(XB.x,w);
while true
    [X,w]= trial(XB,s0,w);
    if (X.y < XB.y)
        while true
            XB_old = XB;
            XB = X;
            X.x = 2*XB.x - XB_old.x;
            [X.y,w] = fit_fun(X.x,w);
            [X,w] = trial(X,s0,w);
            if(X.y >= XB.y)
                break
            end
            if(w>Nmax)
                x_opt = XB.x;
                y_opt = XB.y;
                return
            end
        end
    else
        s0=alfa*s0;
    end
    if s0<epsilon || w > Nmax
        x_opt = XB.x;
        y_opt = XB.y
        return
    end 
end





function [X,w] = trial(X,s,w)
D = eye(length(X.x));
for i=1:length(X.x)
    X_t.x=X.x + s*D(:,i);
    [X_t.y,w] = fit_fun(X_t.x,w);
    if (X_t.y < X.y)
        X = X_t;
    else
        X_t.x=X.x - s*D(:,i);
        [X_t.y,w] = fit_fun(X_t.x,w);
        if (X_t.y < X.y)
            X = X_t;
        end
    end
end

