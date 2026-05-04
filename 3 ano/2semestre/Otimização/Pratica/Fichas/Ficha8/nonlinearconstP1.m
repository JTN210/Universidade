function [c,ceq] = nonlinearconstP1(w)

syms w1 w2

c=[];
ce=w1^2+w2^2-2;
%calcular no ponto w\double(subs(fun,[w1;w2],w))
ceq=double(subs(ce,[w1;w2],w))
end