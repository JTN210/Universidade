import java.util.Arrays;
import java.util.Scanner;

public class Main {

    public static int[] readArray(Scanner scanner){
        System.out.print("Tamanho do array: ");
        int size = scanner.nextInt();
        int[] array = new int[size];

        for(int i = 0; i<size;i++){
            System.out.print("Numero na posição " + i + ": ");
            array[i] = scanner.nextInt();
        }

        return array; 
    }
    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);
        Ficha2Ex1 ficha2Ex1 = new Ficha2Ex1();    
        int[] array = readArray(scanner);

        System.out.print("Introduza o numero de exercicios (1-7): ");
        int exercise = scanner.nextInt();

        switch (exercise) {
            case 1:
                System.out.println("Exercicio 1");
                int min = ficha2Ex1.min(array);
                System.out.println("O minimo do array é: " + min);
                System.out.println("Copiar o array entre: ");
                int from = scanner.nextInt();
                int to = scanner.nextInt();
                int[] newArray = ficha2Ex1.inBetween(array, from, to);
                System.out.println("O novo array é: " + Arrays.toString(newArray));


                break;

            
            case 2:
                System.out.println(" Exercicio 2");

                break;
            default:
                System.out.println("Exercicio não encontrado");
                break;
        }
        scanner.close();
    }


}