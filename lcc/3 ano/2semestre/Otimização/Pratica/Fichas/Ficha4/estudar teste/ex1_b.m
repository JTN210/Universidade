clear all;

syms w1 w2 eta;
ponto = [1 0];
F = (w1 +w2^2)^2;
s = [-1 1];
new_ponto = ponto+eta*s;
new_F = subs(F,[w1 w2],[new_ponto(1) new_ponto(2)]);
grad = gradient(new_F);
pontos_estacionarios = solve(grad,eta);
val_eta = pontos_estacionarios(1);
hess = hessian(new_F,eta);
minimizante = subs(hess,eta,val_eta)
