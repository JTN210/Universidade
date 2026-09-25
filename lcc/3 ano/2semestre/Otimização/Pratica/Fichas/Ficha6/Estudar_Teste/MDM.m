function[f_opt, w_opt,output] = MDM(Fwithgrad,w0,epsilon,kmax)
    k=0;
    wk=w0;
    output=[];
    while k < kmax
        [Fk, gradk] = Fwithgrad(wk);
        norma=norm(gradk,inf);
        if norma<=epsilon
            output=[output; k wk' Fk gradk' eta norma];
            break
        end
        sk=-gradk;
        eta=0.05;
        output=[output; k wk' Fk gradk' eta norma];
        wk=wk+eta*sk;
        k=k+1;
    end
    f_opt = Fk;
    w_opt = wk;
end