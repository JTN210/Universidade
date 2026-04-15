clear all;

syms w1 w2 
w = [1 0];
s = [-1;1];
F = (w1+w2^2)^2;
grad=gradient(F,[w1 w2]);

gradw = subs(grad,[w1 w2],w);

val = dot(gradw',s)
% como val < 0 então s é uma direção de descida


