function [y,w] = fit_fun(x,w,c,a,isInnerPenalty)

w=w+1;

y=sin(pi*((x(1)/pi)^2+(x(2)/pi)^2)^0.5)/(pi*((x(1)/pi)^2+(x(2)/pi)^2)^0.5);

%kara wewnetrzna
% p =  - 1/g1 - 1/g2 - 1/g3
%dodatkowo if g>0 to p=Inf;
%dodatkowo jezeli mamy wewnetrzna funkcje kary trzeba sprawdzic czy punkt
%startowy znajduje sie w obszarze zabronionym (nie moze byc calego
%simpleksu w obszarze zabronionym
% w metodzie kary wewnetrznej wspolczynnik C maleje

%kara zewnetrzna
if isInnerPenalty == false
  p=max(0,-x(1)+1)^2+max(0,-x(2)+1)^2+max(0,(x(1)^2+x(2)^2)^0.5-a)^2;
else
  g1 = -x(1) + 1;
  g2 = -x(2) + 1;
  g3 = sqrt(x(1)^2+x(2)^2) - a;
  if g1 > 0 || g2 > 0 || g3 > 0
    p = Inf;
  else  
    p = -1/g1 - 1/g2 - 1/g3;
  end
end;  
    
y=y+c*p;


