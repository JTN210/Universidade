
public class Ficha2Ex1 {
    
    public int min(int[] array){
        int result = Integer.MAX_VALUE;

        for( int i = 0; i < array.length; i++){
            if(array[i] < result){

                result = array[i];
            }
        }
        return result;

    }

    public int[] inBetween(int[]array, int from, int to){

        if (array.length == 0 || from < 0 || to >= array.length || to < from){
            return null;
        }

        int size = to - from;
        int[]result = new int [size];

        for (int i = 0; i< size; i++) {
            result[i] = array[from + i];
        }


        return result;
    }


    public int[] elementos_Comum(int[] a, int[] b) {
        // Array temporário para armazenar os elementos comuns (tamanho máximo é a.length)
        int[] temp = new int[a.length];
        int tamanhoReal = 0;
        
        for (int i = 0; i < a.length; i++) {
            for (int j = 0; j < b.length; j++) {
                if (a[i] == b[j]) {
                    // Verifica se o elemento já foi adicionado para evitar duplicatas
                    boolean jaAdicionado = false;
                    for (int k = 0; k < tamanhoReal; k++) {
                        if (temp[k] == a[i]) {
                            jaAdicionado = true;
                            break;
                        }
                    }
                    if (!jaAdicionado) {
                        temp[tamanhoReal] = a[i];
                        tamanhoReal++;
                    }
                    // Se encontrou o elemento em b, não precisa continuar o loop interno
                    break;
                }
            }
        }
        
        // Cria um array de tamanho exato para os elementos comuns encontrados
        int[] resultado = new int[tamanhoReal];
        for (int i = 0; i < tamanhoReal; i++) {
            resultado[i] = temp[i];
        }
        
        return resultado;
    }
        
}

