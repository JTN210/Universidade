clear, clc, close all;

% Parâmetros do Problema 
a = 20;
w0 = [20; 1];
epsilon = 1e-4; 
Kmax = 1000;    
etas = [0.1, 0.01, 0.001];

% Escolha qual eta quer simular agora (ex: eta = 0.05)
eta_const = etas(3); 

% Algoritmo: Método de Descida Máxima (MDM) com Passo Constante
w = w0;
history = []; 

for k = 0:Kmax
    [f, gradf] = Fquadratica(w);
    
    % Cálculo da norma infinito para a tabela
    norm_grad_inf = max(abs(gradf));
    
    % Guardar dados da iteração
    history = [history; k, w(1), w(2), norm_grad_inf, eta_const, f];
    
    % Critério de paragem (Norma 2)
    if norm(gradf) <= epsilon
        break;
    end
    
    % Atualização: w(k+1) = w(k) - eta * grad(f)
    w = w - eta_const * gradf;
end

% Apresentação dos Resultados (Tabela)
fprintf('Tabela de Iterações (eta = %.4f):\n', eta_const);
fprintf(' k \t w1 \t\t w2 \t\t ||grad||_inf \t eta \t F(w)\n');
disp(history(1:min(10, end), :)); % Mostra as primeiras 10 iterações

% Gráfico das Curvas de Nível e Trajetória
[W1, W2] = meshgrid(-2:0.5:22, -2:0.5:5);
Z = (W1.^2 + a * W2.^2) / 2;

figure;
contour(W1, W2, Z, 30); hold on;
plot(history(:,2), history(:,3), 'ro-', 'LineWidth', 1, 'MarkerSize', 3);
plot(w0(1), w0(2), 'gx', 'LineWidth', 2, 'MarkerSize', 10); % Ponto inicial
title(['Trajetória MDM com \eta = ', num2str(eta_const)]);
xlabel('w_1'); ylabel('w_2'); colorbar; grid on;