clear, clc, close all;
%format long;
%%
syms w1 w2
beta = 15; %1;5;15
F = w1^2+beta*w2^2;
grad = gradient(F,[w1,w2]);

%%

w0 = [10;1] ; % ponto inicial
epsilon = 0.000001;
Kmax = 200; % numero maximo de iterações
%% aplicar o algoritmo Método de Descida Maxima com procura exata do eta 
[w_opt,Fval_opt,output] = MDM_procuraExata(F,grad,w0,epsilon);

%% grafico das curvas de nivel de F
[w1 w2] = meshgrid(-5:0.01:10, -5:0.01:5);
vals_F = w1.^2 + beta*w2.^2;

figure
contour(w1,w2,vals_F,10);
colorbar;
xlabel('w_1');
ylabel('w_2');
hold on;
vals_w1 = output(:,2);
vals_w2 = output(:,3);
plot(vals_w1q, vals_w2,'ro-','LineWidth', 1,  'MarkerFaceColor','r','MarkerSize', 4); % ponto ótimo
text(vals_w1(1),vals_w2(1)+0.2,'w0')
text(vals_w1(end),vals_w2(end)+0.5,'w*')
title('Curvas de Nível de F');
grid on

%------------
function [w_opt,Fval_opt,output] = MDM_procuraExata(F,grad,w0,epsilon) 

    syms w1 w2 eta;
    k = 0;
    Kmax = 200;
    wk = w0;
    output = [];
    while( k <= Kmax)
        gradk = double(subs(grad,[w1 w2],[wk(1) wk(2)]));
        norma = norm(gradk,inf);
        if(norma <= epsilon)
            w_opt = wk;
            Fk = double(subs(F,[w1 w2],[wk(1) wk(2)]));
            Fval_opt = Fk;
            [k wk' Fk gradk' etak norma]
            output = [output; k wk' Fk gradk' etak norma];
            break;
        end
        % direção
        sk = - gradk;
        
        %% calcular eta com procura exata: minimizar phi(eta) = F(wk+eta*sk)
        waux = wk+eta*sk;
        phi = subs(F,[w1 w2],[waux(1) waux(2)]);
        %calcular os pontos estacionarios de phi
        grad_phi = gradient(phi);
        sol_pe = double(solve(grad_phi==0,eta));
        vals_phi = double(subs(phi,eta,sol_pe));
        [min_phi index] = min(vals_phi);
        etak = sol_pe(index);
        %%
        Fk = double(subs(F,[w1 w2],[wk(1) wk(2)]));
        [k wk' Fk gradk' etak norma]
        output = [output; k wk' Fk gradk' etak norma];
        %%novo ponto
        wk = wk+etak*sk;
        k = k+1
    end
end
