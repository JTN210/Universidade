package guiao1;

class Counter{
    private int value = 0;

    public void increment(){
        value +=1;
    }
    public int value(){
        return value;
    }
}


class Incrementer extends Thread {

    final int I;
    final Counter c;

    public Incrementer(int I, Counter c){
        this.I = I;
        this.c = c;
    }
    public void run(){
        for(int i = 0; i < I; i++){
            //System.out.println(i);
            c.increment();
        }
    }
}

public class Ex2 {
    public static void main (String[] args) throws InterruptedException{
        final int N = Integer.parseInt(args[0]);
        final int I = Integer.parseInt(args[1]);

        Counter c = new Counter();
        Incrementer[] a = new Incrementer[N];
        for (int i = 0; i < N; i++){
            a[i] = new Incrementer(I,c);
        }
        for (int i = 0; i < N; i++){
            a[i].start();
        }
        for (int b = 0; b<N; b++){
            a[b].join();
        }
        System.out.println(c.value());
    }
}