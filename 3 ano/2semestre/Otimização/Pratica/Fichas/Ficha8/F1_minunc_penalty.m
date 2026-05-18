    clear, clc, close all;

options = optimoptions('fminunc','Display','iter');

w0 = [0;0];
mu = 1;
[wopt,Qopt,exitflag,output] = fminunc(@(w)penalty(w,mu),w0,options)


