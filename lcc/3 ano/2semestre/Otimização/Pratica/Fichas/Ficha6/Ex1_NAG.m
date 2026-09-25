clear, clc, close all;

% 1. Parâmetros do Problema (conforme enunciado)
w0 = [20; 1];           % Ponto inicial
epsilon = 1e-4;         % Critério de paragem
Kmax = 1200;            
beta = 0.9;             % Coeficiente de momentum
etas = [0.1, 0.01, 0.001];
eta_fixo = etas(3);     % Exemplo com eta = 0.0952

% 2. Inicializaçãoeta
w = w0;
w_old = w0;
tabela = [];

% 3. Algoritmo NAG
for k = 0:Kmax
    % Passo A: Calcular o ponto de previsão (Look-ahead)
    % y = w(k) + beta * (w(k) - w(k-1))
    if k == 0
        y = w;
    else
        y = w + beta * (w - w_old);
    end
    
    % Passo B: Calcular gradiente no ponto previsto (a "mágica" do NAG)
    [f_y, grad_y] = Fquadratica(y);
    
    % Passo C: Guardar dados para a tabela (usando o w atual)
    [f_w, grad_w] = Fquadratica(w);
    norm_grad_inf = max(abs(grad_w));
    tabela = [tabela; k, w(1), w(2), norm_grad_inf, eta_fixo, f_w];
    
    % Passo D: Critério de paragem (norma-2 conforme enunciado)
    if norm(grad_w) <= epsilon
        fprintf('NAG convergiu em %d iterações\n', k);
        break;
    end
    
    % Passo E: Atualização NAG
    % w(k+1) = y - eta * grad(y)
    w_next = y - eta_fixo * grad_y;
    
    % Preparar próxima iteração
    w_old = w;
    w = w_next;
end

% 4. Resultados
disp('Tabela de Iterações (NAG):');
disp(array2table(tabela, 'VariableNames', {'k', 'w1', 'w2', 'grad_inf', 'eta', 'Fw'}));

% 5. Gráfico de Trajetória
[W1, W2] = meshgrid(-2:1:22, -2:0.5:2);
Z = (W1.^2 + 20 * W2.^2) / 2; % Função do enunciado
figure; contour(W1, W2, Z, 20); hold on;
plot(tabela(:,2), tabela(:,3), 'm.-', 'LineWidth', 1.5);
plot(w0(1), w0(2), 'go', 'MarkerFaceColor', 'g');
title(['NAG: \eta = ', num2str(eta_fixo), ' | \beta = ', num2str(beta)]);
xlabel('w1'); ylabel('w2'); grid on;