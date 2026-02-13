package ficha2;

public class ex1 {
    private int[] numeros;
    
    public void recebeArray(int vector[], int dimensao) {

        this.numeros = new int[dimensao];

        for( int i = 0; i < dimensao; i++)
        {
            this.numeros[i] = vector[i];
        }
    }

    public int minimo(){
        int minimo = numeros[0];
         for(int i = 0; i < numeros.length; i++)
        {
            if( minimo > numeros[i])
                minimo = numeros[i];
        }
        return minimo;
    }

    public int[] valoresEntre (int inicio, int fim){
        int tamanho = fim - inicio + 1; 
        int[] resultado = new int[tamanho];
        int j = 0;
        for( int i = inicio; i < fim + 1; i++)
            {
                resultado[j] = numeros[i];
                j++;
            } 
        return resultado;
    }

    public int[] iguais(int[]ArrayA, int[]ArrayB){
        int tamanho_max = Math.min(ArrayA.length, ArrayB.length);
        int[] comuns = new int[tamanho_max];
        int count = 0;

        for( int i = 0; i < ArrayA.length; i++)
        {
            for(int j = 0; i < ArrayB.length; j++)
            {
                if(ArrayA[i] == ArrayB[j])
                {
                    comuns[count] = ArrayA[i];
                    count++;
                    break;
                }
            }
        }
        int[] resultado = new int[count];
        for(int i = 0; i < count; i++)
        {
            resultado[i] = comuns[i];
        }
        return resultado;
    }
}
