public class ex1 {
 
    
    class Barrier 
    {

        private final int N;
        private int count = 0;

        public Barrier (int N)
        {
           this.N = N; 
        }
        public synchronized void await() throws InterruptedException 
        {
            count += 1;
            if (count < N) 
            {
                while (count < N)
                {
                wait();   
                }
            }
            else
            {
            notifyAll();
            }
        }
    }
}

