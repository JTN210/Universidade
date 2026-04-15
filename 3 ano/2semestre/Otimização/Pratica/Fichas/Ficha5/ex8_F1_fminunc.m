clear, clc, close all;

path(path,'Ficha5')

options = optimoptions('fminunc','Display','iter','SpecifyObjectiveGradient',true);

w0 = [-1.2;1];

[wopt,Fopt,exitflag,output] = fminunc(@F1withgrad,w0,options)