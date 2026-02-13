% 1. Definir a grelha 
[w1, w2] = meshgrid(-2:0.05:4, -1:0.05:5);

% 2. Definir a nova função F(w1, w2)
F = (1 - w1).^2 + (1 - w2).^2 + 0.5 * (2*w2 - w1.^2).^2;

% 3. Criar a figura
figure; hold on; box on;
title('Curvas de Nível de F(w1, w2)');
xlabel('w1'); ylabel('w2');

% 4. Desenhar curvas de nível (contour)
% Usei 50 níveis para maior detalhe
contour(w1, w2, F, 50, 'LineWidth', 1.2);
colorbar; % Adiciona legenda de cores para o valor de F

% 5. Desenhar eixos de referência
plot([-2 4], [0 0], 'k--', 'LineWidth', 1); % eixo x
plot([0 0], [-1 5], 'k--', 'LineWidth', 1); % eixo y


% Definir a função como uma função anónima para o solver
fun = @(w) (1 - w(1))^2 + (1 - w(2))^2 + 0.5 * (2*w(2) - w(1)^2)^2;

% Ponto inicial (chute inicial) baseado no gráfico
w0 = [1, 1];

% Resolver
[w_opt, fval] = fminsearch(fun, w0);

fprintf('O minimizante encontrado é: w1 = %.4f, w2 = %.4f\n', w_opt(1), w_opt(2));
fprintf('O valor mínimo da função é: %.4f\n', fval);

% Marcar o ponto no gráfico anterior
plot(w_opt(1), w_opt(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
text(w_opt(1)+0.1, w_opt(2), 'Minimizante numérico');
