clear all;

syms w1 w2;

F = 4*w1^2-4*w1*w2+w2^2;

grad = gradient(F,[w1 w2])
hess = hessian(F,[w1 w2])

[pontos_estacionarios1 pontos_estacionarios2] = solve(grad,[w1,w2])

