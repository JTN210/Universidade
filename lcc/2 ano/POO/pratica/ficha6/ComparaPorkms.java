package ficha6;

import java.util.Comparator;

public class ComparaPorkms implements Comparator<Carro> {
    public int compare(Carro a, Carro b) {
        return Integer.compare(a.getkms(), b.getkms());
    }
}
