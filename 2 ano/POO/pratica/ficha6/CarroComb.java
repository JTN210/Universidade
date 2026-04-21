package ficha6;
import java.util.Objects;

public class CarroComb extends Carro{
    private float consumoLitros100km, precolitro;
    private double capacidadeDeposito; 
    private double conteudoAtual;

   public double custoPorKm() {
        double custoBase = (consumoLitros100km / 100) * precolitro;
        return custoBase * 1.15;
    }

    public Object clone()
    {
        return new CarroComb();   
    }
    
    public int hashcode()
    {
        return Objects.hash(super.hashCode(),consumoLitros100km,precolitro);
    }

    public double autonomia()
    {
        return (double)((this.conteudoAtual / this.consumoLitros100km)*100);
    }

    public void abastecer()
    {
        this.conteudoAtual = this.capacidadeDeposito;
    }

}
