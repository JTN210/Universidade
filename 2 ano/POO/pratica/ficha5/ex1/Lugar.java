package ex1;
public class Lugar{

    private String matricula;
    private String nome;
    private int minutos;
    private boolean permanente;

    public Lugar(String matricula, String nome,  int minutos,  boolean permanente)
    {
        this.matricula = matricula;
        this.nome = nome;
        this.minutos = minutos;
        this.permanente = permanente;

    }
    public  String getMatricula()
    {
        return matricula;
    }

    public String getNome()
    {
        return nome; 
    }

    public int getMinutos()
    {
        return minutos;
    }

    public boolean getPermanente()
    {
        return permanente;
    }
    
    public void setMatricula(String matricula)
    {
        this.matricula = matricula;
    }

    public void setNome(String nome)
    {
        this.nome = nome;
    }

    public void setMinutos(int minutos)
    {
      this.minutos = minutos;
    }

    public void setPermanente(Boolean permanente)
    {
        this.permanente = permanente;
    }

    public Lugar clone()
    {
    return new Lugar(this.matricula, this.nome, this.minutos, this.permanente);
    }
}

