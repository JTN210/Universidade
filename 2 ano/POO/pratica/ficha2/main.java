package ficha2;

import java.util.Arrays;
import java.util.Scanner;

public class main {
    public static void Main(String[] args) {

    Scanner sc = new Scanner(System.in);

        System.out.print("Tamanho do primeiro array: ");
        int n1 = sc.nextInt();
        int[] array1 = new int[n1];
        for(int i = 0; i < n1; i++) {
            System.out.print("Array 1 - posição " + i + ": ");
            array1[i] = sc.nextInt();
        }

        System.out.print("\nTamanho do segundo array: ");
        int n2 = sc.nextInt();
        int[] array2 = new int[n2];
        for(int i = 0; i < n2; i++) {
            System.out.print("Array 2 - posição " + i + ": ");
            array2[i] = sc.nextInt();
        }

        ex1 ferramenta = new ex1();
        int[] comuns = ferramenta.iguais(array1, array2);

        System.out.println("\nElementos comuns encontrados:");
        System.out.println(Arrays.toString(comuns));
        sc.close();
    }
}