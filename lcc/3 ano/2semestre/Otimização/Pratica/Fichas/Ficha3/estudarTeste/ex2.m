clear

syms w;

F = 3*w^3+7*w^2-15*w-3; 
grad = gradient(F,w)
hess = hessian(F,w)

pontos = double(solve(grad,w))

Maximizante_minimizante = double(subs(hess,w,pontos))

Max_min = double(subs(F,w,pontos))

% para confirmar se é global tenho de fazer limite para + e - infinito
% como deu infinito nos dois, não existe maximo e minimo global.
