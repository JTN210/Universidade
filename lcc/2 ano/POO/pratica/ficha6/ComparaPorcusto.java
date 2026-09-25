package ficha6;

import java.util.Comparator;

public class ComparaPorcusto implements Comparator<Carro> {
    public int compare(Carro a, Carro b) {
        int byCost = Double.compare(a.custoPorKm(), b.custoPorKm());
        if (byCost != 0) {
            return byCost;
        }
        return a.getCod().compareTo(b.getCod());
    }
}
