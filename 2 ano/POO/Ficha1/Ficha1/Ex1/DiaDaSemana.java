import java.util.Scanner;

public class DiaDaSemana {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // Entrada do usuário
        System.out.print("Digite o dia: ");
        int dia = scanner.nextInt();
        System.out.print("Digite o mês: ");
        int mes = scanner.nextInt();
        System.out.print("Digite o ano: ");
        int ano = scanner.nextInt();

        int diasPassados = calcularDiasDesde1900(dia, mes, ano);
        int diaSemana = diasPassados % 7; // 0 - Domingo, 6 - Sábado
        
        // Exibir resultado
        String[] dias = {"Domingo", "Segunda-feira", "Terça-feira", "Quarta-feira", 
                         "Quinta-feira", "Sexta-feira", "Sábado"};
        System.out.println("O dia da semana é: " + dias[diaSemana]);

        scanner.close();
    }

    private static int calcularDiasDesde1900(int dia, int mes, int ano) {
        // Passo 1: Calcular anos completos desde 1900
        int anosPassados = ano - 1900;
        int diasTotais = anosPassados * 365;

        // Passo 2: Adicionar anos bissextos
        diasTotais += (anosPassados / 4);

        // Passo 3: Ajuste se o ano for bissexto e a data estiver em Janeiro ou Fevereiro
        if (isBissexto(ano) && (mes == 1 || mes == 2)) {
            diasTotais -= 1;
        }

        // Passo 4: Adicionar os dias do ano corrente até o mês dado
        int[] diasMes = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}; // Dias até o mês
        for (int i = 1; i < mes; i++) {
            diasTotais += diasMes[i];
        }

        // Adicionar o dia do mês atual
        diasTotais += dia;

        return diasTotais;
    }

    private static boolean isBissexto(int ano) {
        return (ano % 4 == 0);
    }
}
