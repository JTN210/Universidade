clear,clc,close all;

syms w1 
F=w1^2-w1^4/4;
grad=gradient(F,w1);
hess=hessian(F,w1);

%w0=sqrt(2/5);
w0=0.5;
epsilon=0.000001;
Kmax=20;
% aplicar o algoritmo Método de Newton com eta = 1 constante
[w_opt,Fval_opt,output]=MN(F,grad,hess,w0,epsilon,Kmax);

%% grafico de F
% criar pontos w
w = linspace(-1,1,100);
vals_F = w.^2-(w.^4)/4;

figure
plot(w,vals_F,'LineWidth',2);
xlabel('w');
ylabel('F');

hold on
% desenhar os pontos gerados e trajetória(wk,fk);
vals_w = output(:,2);
vals_F = output(:,3);
plot(vals_w,0,'ro','MarkerFaceColor','r');
plot(vals_w,vals_F,'ko--','LineWidth',0.5);
title('Grafico de F, pontos gerados pelo NM e trajetória')
grid on
%--------------------------------
function [w_opt,Fval_opt,output]=MN(F,grad,hess,w0,epsilon,Kmax)

    syms w1;

    k=0;
    wk=w0;
    output=[];
    etak=1;
    while(k<=Kmax)
        gradk=double(subs(grad,w1,wk(1)));
        hessk=double(subs(hess,w1,wk(1)));
        norma=norm(gradk,inf);
        if (norma<=epsilon)
            w_opt=wk;
            Fk=double(subs(F,w1,wk(1)));
            [k wk' Fk gradk' etak norma]
            output=[output;k wk' Fk gradk' etak norma];
            break;
        end
        sk=-hessk\gradk;
        Fk=double(subs(F,w1,wk(1)));
        [k wk' Fk gradk' etak norma]
        output=[output;k wk' Fk gradk' etak norma]
        wk=wk+etak*sk;
        k=k+1;
    end
    w_opt=wk;
    Fval_opt=Fk;
end


