import java.util.*


public class ex1 {



interface Jogo 
{
    Partida participa() throws InterruptedException;
}


interface Partida {
    String adivinha(int n);
}
    class JogoImpl implements Jogo
    {
        PartidaImpl partida = new PartidaImpl();
        public synchronized Partida participa() throws InterruptedException
        {
            PartidaImpl minhaPartida = partida;
            minhaPartida.N_jogadores += 1;
            if (minhaPartida.N_jogadores < 4)
            {
                while (minhaPartida.N_jogadores < 4)
                {
                    wait();
                }    
            }
            else
            {
                partida.start();
                partida = new PartidaImpl();
                notifyAll();
                

            }

            return minhaPartida;
        }

    }

    class PartidaImpl implements Partida
    {
        private int N_jogadores = 0;
        int numero = new Random().nextInt(100) + 1;
        boolean timeout = false;
        boolean ganhou = false;
        int tentativas = 0;

        synchronized void timeout()
        {
            timeout = true;
        }
        private void start()
        {
            new Thread( () -> {
                try
                {
                    Thread.sleep(60000);
                } 
                catch(InterruptedException ignored)
                {}
                timeout();
            }).start();
        }
       public synchronized String adivinha(int n)
        {
            tentativas += 1;
            if (ganhou)
            {
                return "PERDEU";
            }

            if (timeout)
            {
              return "TEMPO";   
            }

            if (tentativas > 100)
            {
                 return "TENTATIVAS";
            }

            if (n == numero)
            {
                return "GANHOU";
                ganhou = true;
            }

            if (n > numero)
            {
                return "MENOR";
            }

            if (n < numero) 
            {
                return "MAIOR";
            }
        }
    }
}
