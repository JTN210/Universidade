function [f, gradf] = Fquadratica(w)
    % Parâmetro dado no enunciado
    a = 20; 
    
    % Cálculo da função no ponto w
    f = (w(1)^2 + a * w(2)^2) / 2;
    
    % Cálculo do gradiente no ponto w
    gradf = [w(1); a * w(2)];
end