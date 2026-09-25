clear all;

syms w1 w2;

F = 0.1*w1^6-1.5*w1^4+5*w1^2+0.1*w2^4+3*w2^2-9*w2+0.5*w1*w2;

w =[-1.25 1.25];
s = [4 0.75];
c = 10^-4;
p = 0.7;
eta = 0.05;
grad = gradient(F,[w1 w2]);
hess = hessian(F,[w1 w2]);
while(subs(F,[w1 w2],w+eta*s) > subs(F,[w1 w2],w) + c*eta*subs(grad,[w1 w2],w)*s)
    eta = p*eta;
end
