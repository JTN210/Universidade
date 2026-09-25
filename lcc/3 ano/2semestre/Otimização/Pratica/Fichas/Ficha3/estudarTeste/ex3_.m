clear all;

syms w1 w2;
F = (1/3)*w1^3+(1/2)*w1^2+2*w1*w2+(1/2)*w2^2-w2+9;

grad = gradient(F,[w1 w2]);
hess = hessian(F,[w1 w2]);
[pontos_estacionarios1 pontos_estacionarios2] = solve(grad==0,[w1 w2])
ponto1 = subs(hess,[w1 w2], [pontos_estacionarios1(1) pontos_estacionarios2(1)]);
ponto2 = subs(hess,[w1 w2], [pontos_estacionarios1(2) pontos_estacionarios2(2)]);

det_ponto1 = det(ponto1); % é 3 e -1 logo a matriz é indefinida por isso é ponto sela
det_ponto2 = det(ponto2); % é 5 e 1 logo a matriz é definida positiva
% logo o ponto2 =(2,-3) é  minimizante local
minimo = double(subs(F,[w1 w2], [2 -3]))
% e o minimo é 9.1667 
% a função n tem minimo global porque se fizer lim infinito de F ela vai
% tender para infinito logo não tem global

