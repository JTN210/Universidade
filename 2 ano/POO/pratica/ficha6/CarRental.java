
package ficha6;
import java.util.List;
import java.util.Set;
import java.util.ArrayList;
import java.util.stream.Collectors;
import java.util.stream.Collector;
import java.util.Iterator;
import java.util.*;

public class CarRental {

    private List<Carro> carros = new ArrayList<>();

    public boolean existeCarro(String cod)
    {
        for(Carro c: carros)
        {
            if (c.getCod().equals(cod))
            {
              return true;   
            }
        }
        return false;
    }
    public int quantos()
    {
        return carros.size();   
    }
    
    public int quantos(String marca)
    {
        return (int)(carros.stream().filter((Carro c) -> c.getmarca().equals(marca)).count());
    }
    
    public Carro getCarro(String cod)
    {
        return carros.stream().filter(c ->c.getCod().equals(cod)).findAny().get();
    }
    
    public void adiciona(Carro carro)
    {
        if (existeCarro(carro.getCod()))
            {
                return;    
            }
            carros.add((Carro)carro.clone());
        }
        
    public List<Carro> getCarros()    
    {
        return carros.stream().map((Carro c) -> (Carro)c.clone()).collect(Collectors.toList());
    }   

    public void adiciona(Set<Carro> vs)
    {
        vs.stream().map((Carro c) -> (Carro)c.clone()).forEach(c -> this.carros.add(c));
    }

    public void registarViagem(String codCarro, int numKms)
    {
        carros.stream().filter((Carro c) -> c.getCod().equals(codCarro)).forEach((Carro c) -> c.setkms(numKms));
    }

    public void atestarcarro(String codCarro)
    {
        this.carros.stream().filter(c -> c.getCod().equals(codCarro))
        .findFirst()
        .ifPresent(c -> c.abastecer());
    }

    public Carro obterCarroMaisEconomico()
    {
        return carros.stream().reduce((Carro a, Carro b)->a.custoPorKm()<b.custoPorKm()?a:b).orElse(null);
    }

    public double obterMediaCustoPorKm()
    {
        return this.carros.stream().mapToDouble(c -> c.custoPorKm()).average().orElse(0.0);
    }

    public int custoRealKm(String cod)
    {
        return (int)(custoPorKm(cod));
    }

    public double custoPorKm(String cod)
    {
       return getCarro(cod).custoPorKm();
    }

    public Set<Carro> carrosComAlcance(int kms)
    {
        return carros.stream().filter((Carro c) -> c.getkmsTotal() >= kms)
        .map((Carro c) ->(Carro)c.clone())
        .collect(Collectors.toSet());
    }

    public Set<CarroEletrico> comBateriaDe(int nivelMinimo)
    {
       return carros.stream().filter((Carro c) -> c instanceof CarroEletrico)
        .map((Carro c) -> (CarroEletrico)c)
        .filter((CarroEletrico c) -> c.getCapacidadebateria()>=nivelMinimo)
        .map((CarroEletrico c) -> (CarroEletrico)c.clone())
        .collect(Collectors.toSet());    
    }
}