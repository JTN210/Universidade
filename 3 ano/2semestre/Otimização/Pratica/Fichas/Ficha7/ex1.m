syms w1 w2 w3 y1

F = w1^4*w2^2 + w1^2*w3^4 + (1/2)*w1^2 + w1*w2 + w3;
c1 = w1 + w2 + w3 - 1;

% Definir a função lagranjiana

L = F-y1*c1;

% Verificar se o ponto é admissivel 
C1_ad = subs(c1, [w1 w2 w3], [1 0 0]);


%Calcular o gradiente da restrição c1

gradC1 = gradient(c1, [w1, w2, w3]);
% como gradc1 != 0 0 0 então é regular


% Verificar as condições de optimalidade 

% Calcular o gradiente da função lagranjiana L
gradL = gradient(L, [w1, w2, w3, y1]);
vec = [0 0 0 0];
[ws1 ws2 ws3 ys1] = solve(gradL == vec);

HessL = hessian(L,[w1 w2 w3])
eig_val = eig(HL_val);
    disp('Valores próprios da Hessiana:');
    disp(eig_val');

