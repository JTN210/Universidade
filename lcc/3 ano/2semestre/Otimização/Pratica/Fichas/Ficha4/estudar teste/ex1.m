clear all;

syms w1 w2;

F = (w1 +w2^2)^2;
s = [-1 1];
ponto = [1 0];
grad = gradient(F,[w1 w2]);

grad1 = subs(grad,[w1 w2], ponto)

conta = dot(grad1',s)

