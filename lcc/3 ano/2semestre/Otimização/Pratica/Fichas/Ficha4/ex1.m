syms w1 w2
F = (w1 + w2^2)^2

gradF = gradient(F,[w1,w2])
gradFw = subs(gradF,[w1,w2],[1,0])

% descida
s = [-1;1]

% calcular produto interno entre s e gradiente
% s' -> ja nos faz a transposta
prod = s' * gradFw

% calcular a taxa de aprendizado
alpha = 0.1;

% ALINEA b) 
 syms eta
phi = subs(F, [w1,w2], [1-eta, eta])
% derivada de phi

gradphi = gradient(phi,[eta])

%calcular os zeros da derivada phi
zerosGradphi = solve(gradphi, eta)
% só vamos ver os zeros que não são complexos
realZerosGradphi = zerosGradphi(imag(zerosGradphi) == 0)

%calcular segunda derivada de phi 

Hessphi = hessian(phi,[eta])

%calcular hessphi no ponto eta = 1/2 para verificar se é > 0
hessphi_eta = subs(Hessphi, [eta],1/2)


%% ALINEA c) 
clear clc;
syms w1 w2 eta;
F = (w1 + w2^2)^2
%% phi(eta) = F(w1+eta*s com w=(1,0) e s = (-1,1)
phi =(1-eta+eta^2)^2;
%% grelha de pontos
etas = linspace(0,5,100);
vals_phi = (1-etas+etas.^2).^2;
%% gráfico
figure;
plot(etas, vals_phi, 'r-','LineWidth',1.5);
xlabel('\etas');
ylabel('\phi(\etas)');
title('Plot of \phi against \etas');
hold on;



%% grafico de F(w1,w2)
 % criar grelha
 [w1,w2] = meshgrid(-5:0.01:5, -5:0.01:5);
 f =(w1+w2.^2).^2;
 figure;
 surfc(w1,w2,f);
 colorbar;
 shading("interp");