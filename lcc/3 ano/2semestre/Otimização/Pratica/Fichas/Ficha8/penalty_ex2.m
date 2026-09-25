function [penaltyQ] = penaltyQ_ex1(w,mu)

    syms w1 w2;

    fun = -5*w1^2+w2^2;

%definir restrição
    c1=w1-1;

%definir a função de penalidade quadrática

    Q=fun+0.5*mu*c1^2;
% Se aqui metermos Q=-1*(fun+0.5*mu*c1^2); temos o maximo;
% Se não estamos a minimizar e assim estamos a maximizar; 

%calcular no ponto w

    penaltyQ=double(subs(Q,[w1;w2],w));
end