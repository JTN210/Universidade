package guiao1;

class Printer extends Thread {

    final int I;

    public Printer(int I){
        this.I = I;
    }
    public void run(){
        for(int i = 0; i < I; i++){
            System.out.println(i);
        }
    }
}

public class Ex1 {
    public static void main (String[] args) throws InterruptedException{
        final int N = Integer.parseInt(args[0]);
        final int I = Integer.parseInt(args[1]);

        Printer[] a = new Printer[N];
        for (int i = 0; i < N; i++){
            a[i] = new Printer(I);
            a[i].start();
        }
        for (int b = 0; b<N; b++){
            a[b].join();
        }
    }
}
