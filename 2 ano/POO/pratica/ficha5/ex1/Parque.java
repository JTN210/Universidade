package ex1;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;


public class Parque {
    private String nomeParque;
    private Map<String, Lugar> lugares;

    public Parque(String nome) {
        this.nomeParque = nome;
        this.lugares = new HashMap<>();
    }

    public String getNomeParque()
    {
        return nomeParque;
    }

    public void setNome(String nomeParque)
    {
        this.nomeParque = nomeParque;
    }

    public ArrayList<String> Allmatriculas()
    {
        Iterator<Lugar> a = this.lugares.values().iterator();
        ArrayList<String> res = new ArrayList<>();
        while (a.hasNext()) 
        {
            Lugar temp = a.next();
            res.add(temp.getMatricula());
        }
        return res;
    }

    public void Registar(Lugar l)
    {
        this.lugares.put(l.getMatricula(), l);
    }

    public void Remove(String matricula)
    {
        this.lugares.remove(matricula);
    }

    public void AltTempo(String matricula, int minutos)
    {
        Lugar l = this.lugares.get(matricula);

        if (l != null)
        {
            l.setMinutos(minutos);
        }
        else
        {
            System.out.println("Matrícula não encontrada: " + matricula);
        }
    }

    public int TotalminExternos()
    {
        int total = 0;
        Iterator<Lugar> a = this.lugares.values().iterator();
        while (a.hasNext()) 
        {
            Lugar l = a.next();
            total += l.getMinutos();    
        }
        return total;
    }   

    public int TotalminInternos()
    {
        return this.lugares.values().stream().mapToInt(l -> l.getMinutos()).sum();
    }

    public boolean VefExiste(String matricula)
    {
        Lugar l = this.lugares.get(matricula);
        return (l != null && l.getPermanente());
    }

    public ArrayList<String> MatriculasExterno(int x)
    {
        Iterator<Lugar> a = this.lugares.values().iterator();
        ArrayList<String> res = new ArrayList<>();
        while (a.hasNext())
        {
            Lugar l = a.next();
            if (l.getPermanente() && l.getMinutos() > x)
            {
                res.add(l.getMatricula());
            }   
        }
        return res;
    }

    public ArrayList<String> MatriculasInterno(int x)
    {
      return this.lugares.values().stream().filter(l -> l.getPermanente() && l.getMinutos() > x)
      .map(Lugar::getMatricula).collect(Collectors.toCollection(ArrayList::new));
    }
     public ArrayList<String> MatriculasInternoV2(int x)
    {
        ArrayList<String> res =  new ArrayList<>();

        this.lugares.values().forEach(
            l->
            {
                if (l.getPermanente() && l.getMinutos() > x)
                {
                res.add(l.getMatricula());   
                }
            }
        );
        return res;
    }
    public Map<String, Lugar> getLugaresCopia()
    {
        Map<String, Lugar> copia = new HashMap<>();
        
        this.lugares.forEach((k, v) -> 
        {
          copia.put(k,v.clone()); 
        });
        return copia;
    }

    public Lugar Valores(String matricula)
    {
        Lugar l = this.lugares.get(matricula);
        if (l != null) 
        {
          return l.clone();  
        }
        return null;
    }
}
