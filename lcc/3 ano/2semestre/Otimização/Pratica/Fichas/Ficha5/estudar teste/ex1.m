clear all;

syms w1 w2 eta;

beta = 15; % 5 15
F = w1^2+beta*w2^2;
w0 = [10;1];
epslon = 10^-6;
output= [];
k= 0;
grad = gradient(F,[w1 w2]);
gradk = subs(grad,[w1 w2],[w0(1) w0(2)]);
norma = norm(gradk);
while(norma > epslon)
   
    sk = -gradk;
    %
    waux = w0+eta*sk;
    new_F = subs(F,[w1 w2],[waux(1) waux(2)]);
    grad_newF = gradient(new_F,eta);
    pontos = double(solve(grad_newF,eta));
    valor =double(subs(new_F,eta,pontos));
    [cona i] = min(valor);
    etak = pontos(i);
    %
    w0 = w0+etak*sk;
    gradk = subs(grad,[w1 w2],[w0(1) w0(2)]);
    norma = norm(gradk);
    [output;k w0' norma' etak]
    k = k +1;
end

