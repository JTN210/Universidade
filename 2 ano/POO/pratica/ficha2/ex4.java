package ficha2;
import java.util.Arrays;

public class ex4 {
    public String[] semRepeticoes(String[] a ){
        String[] unicos = new String[a.length];
        int count = 0;
        Arrays.sort(a);
        for(int i = 0; i < a.length; i++)
        {
           while (a[i] != a[i+1]) {
            
            unicos[count] = a[i];
            count++;
           } 
        }
        String[] resultados = new String[count];
        for(int i = 0; i < count; i++)
        {
            resultados[i] = unicos[i];
        }
        return resultados;
    }    
    
}
