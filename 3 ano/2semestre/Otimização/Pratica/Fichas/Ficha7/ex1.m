clc;clear;
syms w1 w2 w3 y1;

F = w1^2-2*w1+w2^2-w3^2+4*w3;
c1 = w1-w2+2*w3-2;

% Definir a função lagranjiana

L = F-y1*c1;

% Verificar se o ponto é admissivel
w_star = [2.5, -1.5, -1];
C1_ad = subs(c1, [w1 w2 w3], w_star);


%Calcular o gradiente da restrição c1

gradc1 = gradient(c1, [w1, w2, w3]);
% como gradc1 != 0 0 0 então é regular


% Verificar as condições de optimalidade 

% Calcular o gradiente da função lagranjiana L
gradL = gradient(L, [w1, w2, w3]);
gradL_subs = subs(gradL,[w1 w2 w3], w_star);
% agora o meu y1/lambda como a restrição é = o lambda pode ser qualquer
% valor, ele só tem de existir
lambda = solve(gradL_subs == 0)
%Verificar as condições necessárias de 2ª ordem
HessL = hessian(L,[w1 w2 w3]);
HessL_subs = subs(HessL, [w1 w2 w3 y1],[w_star(1) w_star(2) w_star(3) lambda]);

Z=null(gradc1');
sol = Z' * HessL_subs * Z;
eig(sol);