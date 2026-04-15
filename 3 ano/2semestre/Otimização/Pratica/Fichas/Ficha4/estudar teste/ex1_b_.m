clear all;

syms w1 w2 eta;

F = (w1 +w2^2)^2;
s = [-1 1];
ponto = [1 0];
waux = ponto+eta*s;

F_waux = subs(F,[w1 w2],[waux(1) waux(2)]);

grad_aux = gradient(F_waux,[eta]);
grad_value = solve(grad_aux==0,eta);
grad_value(1);
hess = hessian(F_waux,eta);
hes_value = subs(hess,[eta],grad_value(1));
% como o resultado deu > 0 significa que o 1/2 é minimizante

