% 1. Definir o domínio (conforme o slide, de -6 a 6)
[w1, w2] = meshgrid(-6:0.1:6, -6:0.1:6);

% 2. Definir a função
F = w1.^3+2.*w1.*w2.^2-w2.^3-20.*w1;

% --- Gráfico 1: Curvas de Nível (Contour) ---
figure; hold on; box on; 
contour(w1, w2, F, 100, 'LineWidth',1.2); % Usamos 40 linhas para dar detalhe
colorbar;
xlabel('w_1');
ylabel('w_2');
title('Curvas de nível');
grid on;

% --- Gráfico 2: Superfície 3D (fsurf ou mesh) ---
figure;
surf(w1, w2, F);
shading interp; % Suaviza as cores como no slide
colorbar;
xlabel('w_1');
ylabel('w_2');
zlabel('F(w_1,w_2)');
title('Função F(w_1,w_2)');