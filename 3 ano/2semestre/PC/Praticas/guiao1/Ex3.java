package guiao1;

class Counter {
    private int value = 0;

    public void increment(){
        value +=1;
    }
    public int count(){
        return value;
    }
    public int value(){
        return value;
    }
}

class Incrementer extends Thread{
    final int I;
    final Counter c;

    public Incrementer(int I, Counter c){
        this.I = I;
        this.c = c;
    }

    public void run(){
        for(int i = 0; i < I; i++){
            c.increment();
        }
    }
}

class DirectIncrementer extends Thread{
    final int I;
    final Counter c;
    public DirectIncrementer(int I, Counter c){
        this.I = I;
        this.c = c;
    }
    public void run(){
        for (int i = 0; i < I; i++){
            synchronized(c){
                c.increment();
            }
        }
    }
}
public class Ex3 {
    public static void main(String[] args) throws InterruptedException {
        final int N = Integer.parseInt(args[0]);
        final int I = Integer.parseInt(args[1]);
        
        System.out.println("=== VERSÃO 1: Usando método increment() ===");
        for (int tentativa = 0; tentativa < 5; tentativa++) {
            Counter c1 = new Counter();
            Incrementer[] threads1 = new Incrementer[N];
            
            for (int i = 0; i < N; i++) {
                threads1[i] = new Incrementer(I, c1);
            }
            for (int i = 0; i < N; i++) {
                threads1[i].start();
            }
            for (int i = 0; i < N; i++) {
                threads1[i].join();
            }
            
            System.out.println("Tentativa " + (tentativa + 1) + ": " + c1.value() + 
                             " (esperado: " + (N * I) + ")");
        }
        
        System.out.println("\n=== VERSÃO 2: Acesso direto à variável ===");
        for (int tentativa = 0; tentativa < 5; tentativa++) {
            Counter c2 = new Counter();
            DirectIncrementer[] threads2 = new DirectIncrementer[N];
            
            for (int i = 0; i < N; i++) {
                threads2[i] = new DirectIncrementer(I, c2);
            }
            for (int i = 0; i < N; i++) {
                threads2[i].start();
            }
            for (int i = 0; i < N; i++) {
                threads2[i].join();
            }
            
            System.out.println("Tentativa " + (tentativa + 1) + ": " + c2.value() + 
                             " (esperado: " + (N * I) + ")");
        }
    }
}
