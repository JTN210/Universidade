function[w_opt,f_opt,output]=HB(Fwithgrad,w0,eta,beta,epsilon,kmax)
    k=0;
    wk=w0;
    output=[];
    mk=zeros(length(w0),1);
    while k<=kmax
        [Fk,gradfk]=Fwithgrad(wk);
        norma=norm(gradfk,inf);
        if norma<= epsilon
            output=[output; k wk' Fk gradfk' eta norma];
            break
        end
        sk = -gradfk;
        mk=beta*mk+eta*sk;
        output=[output; k wk' Fk gradfk' eta norma];
        wk=wk+mk;
        k=k+1;
    end
    w_opt=wk;
    f_opt=Fk;
end
