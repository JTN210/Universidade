package ficha6;

import java.util.Objects;

public abstract class Carro implements CarroRestrito{
    
    private String cod, marca, modelo;
    private int kms;
    private int kmsTotal;
    private int velMedia;
    private int ano;
    private int autonomia;
    public Carro(String matricula, String marca, String modelo, int ano, int velocidadeMedia, int autonomia, int kms)
    {
  
    this.cod = matricula;
    this.marca = marca;
    this.modelo = modelo;
    this.ano = ano;
    this.velMedia = velocidadeMedia;
    this.autonomia = autonomia;
    this.kms = kms;
  }
    public Carro(Carro outro)
    {
        this.cod = outro.cod;
        this.marca = outro.marca;
        this.modelo = outro.modelo;
        this.kms = outro.kms;
        this.kmsTotal = outro.kmsTotal;
        this.velMedia = outro.velMedia;
        this.ano = outro.ano;
        this.autonomia = outro.autonomia;
    }

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

    public int getKms()
    {
        return getkms();
    }

    public void setkms(int numKms)
    {
        this.kms = numKms;
    }

    public abstract int autonomia();

    public abstract Object clone();

    public abstract double custoPorKm();

    public double getCustoPorKm()
    {
        return custoPorKm();
    }

    public abstract void abastecer();

    public int hashcode()
    {
        return Objects.hash(cod, marca, modelo);

    }


}
