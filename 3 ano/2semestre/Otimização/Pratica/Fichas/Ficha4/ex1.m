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


% ALINEA c) 

etas = linspace(0,5,100)
phi =(1-etas+etas.^2).^2
figure;
plot(etas, phi);
xlabel('\eta');
ylabel('\phi(\eta)');
title('Plot of \phi against \eta');
grid on;

