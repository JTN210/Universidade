w0 = [20;1];      
epsilon = 1e-4;        
kmax = 200;

[f_opt, w_opt, output] = MDM(@Fwithgrad, w0, epsilon, kmax)