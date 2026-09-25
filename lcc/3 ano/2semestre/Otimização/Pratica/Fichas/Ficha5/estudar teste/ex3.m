clear all;

syms w1 w2;
output = [];
w = [-2;1];
c = 0.0001;
p = 0.5;
epslon = 10^-6;
F = (1-w1)^2+(1-w2)^2+(1/2)*(2*w2-w1^2)^2;
grad = gradient(F,[w1 w2]);
norma = double(norm(subs(grad,[w1 w2],[w(1) w(2)])));
wk = w;
k = 0;
while(norma > epslon)
    gradk = double(subs(grad,[w1 w2],[wk(1) wk(2)]));
    sk = -gradk;
    eta = 1;
    waux = wk+eta*sk;
    while double(subs(F,[w1 w2],[waux(1) waux(2)])) > double(subs(F,[w1 w2],[wk(1) wk(2)])+c*eta*(gradk'*sk))
        eta = p*eta;
        waux = wk+eta*sk;
    end
    wk = wk+eta*sk;
    norma = double(norm(subs(grad,[w1 w2],[wk(1) wk(2)])));
    k = k + 1;
end
k

