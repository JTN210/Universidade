import java.time.LocalDate;
import java.time.DayOfWeek;
import java.util.Scanner;

public class DiaDaSemana {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Digite o dia: ");
        int dia = scanner.nextInt();
        System.out.print("Digite o mês: ");
        int mes = scanner.nextInt();
        System.out.print("Digite o ano: ");
        int ano = scanner.nextInt();

        LocalDate data = LocalDate.of(ano, mes, dia);
        DayOfWeek diaSemana = data.getDayOfWeek();
        System.out.println("O dia da semana é: " + diaSemana);
        
        scanner.close();
    }
}
