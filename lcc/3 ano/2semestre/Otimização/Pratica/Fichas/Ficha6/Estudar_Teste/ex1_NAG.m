w0 = [20;1];
eta =0.15;
beta= 0.9; 
epsilon = 1e-4;        
kmax = 300;
[f_opt, w_opt, output] = NAG(@Fwithgrad,w0,eta,beta,epsilon, kmax)