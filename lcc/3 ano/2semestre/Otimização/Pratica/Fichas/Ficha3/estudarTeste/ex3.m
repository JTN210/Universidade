clear all;

syms w1 w2

F = (1/3)*w1^3+(1/2)*w1^2+2*w1*w2+(1/2)*w2^2-w2+9;

grad = gradient(F,[w1 w2]);
hess = hessian(F,[w1 w2]);

vec = [0 0];
[pontos1, pontos2] = solve(grad== vec,[w1 w2])

hess1 = subs(hess,[w1 w2],[1 -1])
hess2 = subs(hess,[w1 w2],[2 -3])

det_hess1 = det(hess1)
det_hess2 = det(hess2)


