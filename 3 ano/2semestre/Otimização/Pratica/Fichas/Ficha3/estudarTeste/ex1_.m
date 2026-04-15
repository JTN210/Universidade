syms w 
F=15-12*w-25*w^2+2*w^3

grad = gradient(F,w);
hess = hessian(F,w);

pontos = double(solve(grad,w))

F_s = double(subs(hess,w,pontos))

Max_min = double(subs(F,w,pontos))