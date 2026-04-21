package ficha6;
import java.util.Objects;

public class CarroEletrico extends Carro {
    private float consumoKWh100km, precoKWh;
    private double capacidadeBateria;
    private double energiaAtual;

    public double getCapacidadebateria()
    {
        return capacidadeBateria;
    }
    
    public double custoPorKm()
    {
        return (double)((consumoKWh100km/100)*precoKWh);
    }

    public Object clone()
    {
        return new CarroEletrico();   
    }
    
    public int hashcode()
    {
        return Objects.hash(super.hashCode(),consumoKWh100km,precoKWh);
    }

    public double autonomia()
    {
        return (double)((this.energiaAtual / this.consumoKWh100km) * 100);
    }
    public void abastecer()
    {
        this.energiaAtual = this.capacidadeBateria;
    }

}
