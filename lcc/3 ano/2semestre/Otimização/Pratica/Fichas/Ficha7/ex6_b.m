clc, clear;
syms w1 w2 y1 y2;

F = (1/2)*w1^2+w2^2;
c1 = 2*w1+w2-2;
c2=1-w1+w2;
gradc1 = gradient(c1, [w1 w2]);
gradc2 = gradient(c2, [w1 w2]);
w = solve([c1 == 0, c2 == 0],[w1 w2]);
w0=[w.w1 w.w2];

L = F-y1*c1-y2*c2;
gradL = gradient(L, [w1 w2]);
HessL = hessian(L,[w1 w2]);
HessL_subs=subs(HessL,[w1 w2],[w0(1) w0(2)]);
eig(HessL_subs);

%Para c1 e c2 ativo
gradL_subs = subs(gradL,[w1 w2],[w0(1) w0(2)]);
lambda= solve(gradL_subs == 0);
%como um dos lambdas é negativo logo não dá para fazer 
% Agora só para c1 ativo 
L1 = F - y1*c1;
gradL1 = gradient(L1, [w1 w2 y1]);
sol1 = solve(gradL1 == 0, [w1 w2 y1]);

%Agora só para c2 ativo
L2 = F - y2*c2;
gradL2 = gradient(L2, [w1 w2 y2]);
sol2 = solve(gradL2 == 0, [w1 w2 y2]);



