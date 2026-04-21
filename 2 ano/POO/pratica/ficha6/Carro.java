package ficha6;

import java.util.Objects;

public abstract class Carro {
    
    private String cod, marca, modelo;
    private int kms;
    private int kmsTotal;
    private int velMedia;
    public int getkmsTotal()
    {
        return kmsTotal;
    }

    public int getvelMedia()
    {
        return velMedia;
    }
    
    public String getCod()
    {
        return cod;
    }

    public String getmarca()
    {
        return marca;
    }

    public String getmodelo()
    {
        return modelo;
    }

    public int getkms()
    {
        return kms;
    }

    public void setkms(int numKms)
    {
        this.kms = numKms;
    }

    public abstract double autonomia();

    public abstract Object clone();

    public abstract double custoPorKm();
    public abstract void abastecer();

    public int hashcode()
    {
        return Objects.hash(cod, marca, modelo);

    }


}
