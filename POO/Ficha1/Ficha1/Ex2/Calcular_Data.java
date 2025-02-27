import java.util.Scanner;

public class Calcular_Data {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter your Day: ");
        int day = scanner.nextInt(); // Read a string

        System.out.print("Enter your month: ");
        int month = scanner.nextInt(); // Read an integer

        System.out.print("Enter your year: ");
        int year = scanner.nextInt();

        System.out.println(day+ "/" + month + "/" + year);

        scanner.close();


    }


}

