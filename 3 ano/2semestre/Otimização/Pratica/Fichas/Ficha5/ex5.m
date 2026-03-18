clear,clc,close all;

syms w1 w2 
F=sqrt(w1^2+1)+sqrt(w2^2+1);
grad=gradient(F,[w1 w2]);
hess=hessian(F,[w1 w2]);

%w0=[1;1];
w0=[0.5;0.5];
epsilon=1e-6;
Kmax=20;
% aplicar o algoritmo Método de Newton com eta = 1 constante
[w_opt,Fval_opt,output]=MN(F,grad,hess,w0,epsilon,Kmax);

%% grafico das curvas de nivel de F
[w1,w2] = meshgrid(-2.5:0.01:2.5, -3:0.01:3);
vals_F = sqrt(w1.^2+1) + sqrt(w2.^2+1);

figure
contour(w1,w2,vals_F,10);
colorbar;
xlabel('w_1');
ylabel('w_2');

hold on
% desenhar os pontos wk obtidos pelo algoritmo
vals_w1 = output(:,2);
vals_w2 = output(:,3);
plot(vals_w1,vals_w2,'ro-','LineWIdth',0.5,'MarkerFaceColor','r','MarkerSize',4);
plot(w_opt(1),w_opt(2),'ko','LineWidth',0.5);
title('Pontos gerados pelo MN e trajetória')
grid on
%--------------------------------
function [w_opt,Fval_opt,output]=MN(F,grad,hess,w0,epsilon,Kmax)

    syms w1 w2;

    k=0;
    wk=w0;
    output=[];
    etak=1;
    while(k<=Kmax)
        gradk=double(subs(grad,[w1 w2],[wk(1) wk(2)]));
        hessk=double(subs(hess,[w1 w2],[wk(1) wk(2)]));
        norma=norm(gradk,inf);
        if (norma<=epsilon)
            w_opt=wk;
            Fk=double(subs(F,[w1 w2],[wk(1) wk(2)]));
            [k wk' Fk gradk' etak norma]
            output=[output;k wk' Fk gradk' etak norma];
            break;
        end
        sk=-hessk\gradk;
        Fk=double(subs(F,[w1 w2],[wk(1) wk(2)]));
        [k wk' Fk gradk' etak norma]
        output=[output;k wk' Fk gradk' etak norma]
        wk=wk+etak*sk;
        k=k+1;
    end
    w_opt=wk;
    Fval_opt=Fk;
end


