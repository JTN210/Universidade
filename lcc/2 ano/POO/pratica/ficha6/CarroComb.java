package ficha6;
import java.util.Objects;

public class CarroComb extends Carro {
    private float consumoLitros100km, precolitro;
    private double capacidadeDeposito; 
    private double conteudoAtual;

    public CarroComb()
    {
        this("", "", "", 0, 0, 0, 0, 0, 0f, 0f);
    }

    public CarroComb(CarroComb c) {
        super(c);
        this.consumoLitros100km = c.consumoLitros100km;
        this.precolitro = c.precolitro;
        this.capacidadeDeposito = c.capacidadeDeposito;
        this.conteudoAtual = c.conteudoAtual;
    }

    public CarroComb(String matricula, String marca, String modelo, int ano, 
               int velocidadeMedia, int autonomia, int kms, int capDeposito,
               float consumo100, float precoLitro) {
      super(matricula, marca, modelo, ano, velocidadeMedia, autonomia, kms);
      this.capacidadeDeposito = capDeposito;
      this.consumoLitros100km = consumo100;
      this.precolitro = precoLitro;
   
   }
   public double custoPorKm() {
        double custoBase = (consumoLitros100km / 100) * precolitro;
        return custoBase * 1.15;
    }

    public Object clone()
    {
        return new CarroComb(this);   
    }
    
    public int hashcode()
    {
        return Objects.hash(super.hashCode(),consumoLitros100km,precolitro);
    }

    public int autonomia()
    {
        return (int)((this.conteudoAtual / this.consumoLitros100km)*100);
    }

    public void abastecer()
    {
        this.conteudoAtual = this.capacidadeDeposito;
    }

}
