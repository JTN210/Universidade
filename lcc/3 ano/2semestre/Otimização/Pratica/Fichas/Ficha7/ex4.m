syms w1 w2 w3 y1
F = w1^4*w2^2 + w1^2*w3^4 + (1/2)*w1^2 + w1*w2 + w3;
c1 = w1 + w2 + w3 - 1;
L = F - y1*c1;

% 1. Ponto de teste
w= [1 0 0];

% 2. Verificar Admissibilidade (C1 deve ser 0)
C1_val = double(subs(c1, [w1 w2 w3], w));
fprintf('Admissibilidade: C1 = %d\n', C1_val);

% 3. Verificar Condição de 1ª Ordem (Estacionaridade)
% Calculamos o gradiente de L apenas em relação a w
gradL_w = gradient(L, [w1 w2 w3]);
gradC1 = gradient(c1, [w1, w2, w3]);

% Substituímos o ponto w e resolvemos para y1
eqs = subs(gradL_w, [w1 w2 w3], w);
sol_y1 = solve(eqs == [0;0;0], y1);

if isempty(sol_y1)
    disp('O ponto NÃO é um ponto estacionário.');
else
    fprintf('Ponto estacionário encontrado com y1 = %d\n', double(sol_y1));
    
    % 4. Verificar Condição de 2ª Ordem
    HL = hessian(L, [w1 w2 w3]);
    HL_val = double(subs(HL, [w1 w2 w3 y1], [w, double(sol_y1)]));
    
    disp('Matriz Hessiana no ponto:');
    disp(HL_val);
    
    % Verificação de valores próprios (se todos > 0, é mínimo local)
    eig_val = eig(HL_val);
    disp('Valores próprios da Hessiana:');
    disp(eig_val');
end