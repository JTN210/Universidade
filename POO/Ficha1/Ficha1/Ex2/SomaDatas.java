public class SomaDatas {
    public static String somaDatas(int d1, int h1, int m1, int s1, int d2, int h2, int m2, int s2) {
        int segundos = s1 + s2;
        int minutos = m1 + m2 + segundos / 60;
        int horas = h1 + h2 + minutos / 60;
        int dias = d1 + d2 + horas / 24;

        segundos %= 60;
        minutos %= 60;
        horas %= 24;

        return String.format("%dD %02dH %02dM %02dS", dias, horas, minutos, segundos);
    }

    public static void main(String[] args) {
        System.out.println(somaDatas(1, 23, 59, 59, 0, 1, 0, 2)); // Exemplo de teste
    }
}
