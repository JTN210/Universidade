package ficha6;
import java.util.Objects;

public class CarroEletrico extends Carro implements Comparable<CarroEletrico> {
    private float consumoKWh100km, precoKWh;
    private double capacidadeBateria;
    private double energiaAtual;

    public CarroEletrico()
    {
        super("", "", "", 0, 0, 0, 0);
        this.consumoKWh100km = 0f;
        this.precoKWh = 0f;
        this.capacidadeBateria = 0;
        this.energiaAtual = 0;
    }



    public CarroEletrico(CarroEletrico outro) {
        super(outro);
        this.consumoKWh100km = outro.consumoKWh100km;
        this.precoKWh = outro.precoKWh;
        this.capacidadeBateria = outro.capacidadeBateria;
        this.energiaAtual = outro.energiaAtual;
    }

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
        return new CarroEletrico(this);
    }

    public int compareTo(CarroEletrico outro) {
        return Integer.compare(this.autonomia(), outro.autonomia());
    }
    
    public int hashcode()
    {
        return Objects.hash(super.hashCode(),consumoKWh100km,precoKWh);
    }

    public int autonomia()
    {
        return (int)((this.energiaAtual / this.consumoKWh100km) * 100);
    }
    public void abastecer()
    {
        this.energiaAtual = this.capacidadeBateria;
    }

}
