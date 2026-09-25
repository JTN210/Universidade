syms w1 w2;

F = log(exp(w1) + exp(w2));
grad = gradient(F,[w1 w2]);
hess = hessian(F,[w1 w2])

