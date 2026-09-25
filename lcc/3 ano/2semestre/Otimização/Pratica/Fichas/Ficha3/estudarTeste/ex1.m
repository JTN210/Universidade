
syms w 
F=15-12*w-25*w^2+2*w^3

grad = gradient(F,w);
hess = hessian(F,w);

pontos = solve(grad,w);

ponto = double(subs(hess,w,pontos))
double(subs(F,w,pontos))


