public class ex2 {
 
    
    class Barrier 
    {

        private final int N;
        private int count = 0;
        private int returned = 0;

        public Barrier (int N)
        {
           this.N = N; 
        }
        public synchronized void await() throws InterruptedException 
        {
            while (returned > 0)
            {
                wait();
            }
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
            returned += 1;
            if (returned == N)
            {
              count = 0;
              returned = 0;
              notifyAll(); 
            }
        }
    }
}

