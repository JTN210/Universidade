clear syms
syms w1 w2
F = (w1^3)/3+(w1^2)/2+2*w1*w2+(w2^2)/2-w2+9;
df_w1 = diff(F,w1);
df_w2 = diff(F,w2);
vec0 = [0;0];
grad = [df_w1;df_w2];
%Existe uma função grad = gradient(F,[w1,w2]);
% Existe uma função hess = hessian(F,[w1,w2]);
hess = [diff(df_w1,w1),diff(df_w1,w2);
        diff(df_w2,w1),diff(df_w2,w2)];
fprintf('gradiente de F:\n'); disp(grad)
fprintf('Hessiana de F:\n'); disp(hess)

% Calcular os pontos estacionarios 
[ws1 ws2] = solve(grad==vec0, [w1,w2]);
fprintf('Pontos estacionarios de F:\n'); disp(double([ws1 ws2]))

[n nc] = size(ws1);
[dim dim1] = size(hess);


for i = 1 :n
    