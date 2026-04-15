clear, clc, close all;

% Parâmetros do Problema
w0 = [20; 1];
epsilon = 1e-4;
Kmax = 1200;
beta = 0.9; % Parâmetro de momento (pode ajustar conforme indicado nas aulas)
etas = [0.1, 0.01, 0.001];

% Selecionar o eta para o teste
eta_fixo = etas(1); % Exemplo com 0.0952

% Inicialização
w = w0;
w_old = w0; % w(k-1)
tabela = [];

% Algoritmo Heavy-ball
for k = 0:Kmax
    [f, gradf] = Fquadratica(w);
    
    % Guardar dados na tabela
    norm_grad_inf = max(abs(gradf));
    tabela = [tabela; k, w(1), w(2), norm_grad_inf, eta_fixo, f];
    
    % Critério de paragem
    if norm(gradf) <= epsilon
        fprintf('Convergência Heavy-ball em %d iterações (eta = %f)\n', k, eta_fixo);
        break;
    end
    
    % Atualização Heavy-ball
    if k == 0
        % No primeiro passo não há termo de momento
        w_next = w - eta_fixo * gradf;
    else
        % w(k+1) = w(k) - eta*grad + beta*(w(k) - w(k-1))
        w_next = w - eta_fixo * gradf + beta * (w - w_old);
    end
    
    % Atualizar variáveis para o próximo ciclo
    w_old = w;
    w = w_next;
end

% Resultados
disp(array2table(tabela, 'VariableNames', {'k', 'w1', 'w2', 'grad_inf', 'eta', 'Fw'}));

% Gráfico
[W1, W2] = meshgrid(-2:1:22, -2:0.5:2);
Z = (W1.^2 + 20 * W2.^2) / 2;
figure; contour(W1, W2, Z, 25); hold on;
plot(tabela(:,2), tabela(:,3), 'b.-', 'LineWidth', 1);
plot(w0(1), w0(2), 'go', 'MarkerFaceColor', 'g');
title(['Heavy-ball: \eta = ', num2str(eta_fixo), ' | \beta = ', num2str(beta)]);
xlabel('w1'); ylabel('w2'); grid on;