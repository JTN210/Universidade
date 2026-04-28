import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;


public class TurmaAlunos {
    private String turma;
    private String uc;
    private Map<String,Aluno> alunos;

    public TurmaAlunos()
    {
        this.turma = "";
        this.uc = "";
        this.alunos = new HashMap<>();
    }

    public TurmaAlunos(String nome, String uc, Map<String,Aluno> alunos)
    {
        this.turma = nome;
        this.uc = uc;
        setAlunos(alunos);
    }

    public TurmaAlunos(TurmaAlunos umaTurma)
    {
        this.turma = umaTurma.getNomeTurma();
        this.uc = umaTurma.getuc();
        this.alunos = umaTurma.getAlunos();
    }

    public String getNomeTurma()
    {
        return turma;

    }
    
    public void setNomeTurma(String turma)
    {
        this.turma = turma;
    }

    public String getuc()
    {
        return uc;
    }

    public void setuc(String uc)
    {
        this.uc = uc;
    }

    public Map<String,Aluno> getAlunos()
    {
        return this.alunos.values().stream().collect(Collectors.toMap((Aluno c) -> c.getNumero(), (Aluno c) ->  (Aluno)c.clone()));
    }

    public void setAlunos(Map<String, Aluno> Novosalunos)
    {
        this.alunos = Novosalunos.values().stream().collect(Collectors.toMap((Aluno c) -> c.getNumero(), (Aluno c) ->  (Aluno)c.clone()));
    }

    
    public String toString()
    {
    StringBuilder sb = new StringBuilder();

    sb.append("uc: ");
    sb.append(this.uc + " - ");
    sb.append("Nome da turma: ");
    sb.append(this.turma);
    sb.append(" - Alunos Registados:\n");
    if (this.alunos.isEmpty()) {
        sb.append("Nenhum aluno registado.");
    } 
    else
    {
        for (Aluno a : this.alunos.values()) 
        {
            sb.append(" - ").append(a.toString()).append("\n");
        }
    }

    return sb.toString();

    }
    
    public boolean equals(Object o)
    {
    if (this == o)
      return true;

    if ((o == null) || (this.getClass() != o.getClass()))
      return false;

    TurmaAlunos umaTurma = (TurmaAlunos) o;
    return (this.uc.equals(umaTurma.getuc()) && this.turma.equals(umaTurma.getNomeTurma()) && this.alunos.equals(umaTurma.getAlunos()));
    }

    public int hashCode()
    {
    return Objects.hash(uc, turma, alunos);
    }

    public int compareTo(TurmaAlunos outra)
    {
        int compUC = this.uc.compareTo(outra.getuc());
        if (compUC != 0)
        {
            return compUC;
        }
        return this.turma.compareTo(outra.getNomeTurma());
    }

    public void insereAluno(Aluno a)
    {
        if (a == null)
        {
            return;
        }

        if (!this.alunos.containsKey(a.getNumero()))
        {
            this.alunos.put(a.getNumero(), a.clone());    
        }
        else
        {
            System.out.println("Aluno com o numero" + a.getNumero() + "já existe na turma.");
        }
    }

    public Aluno getAluno(String codAluno)
    {
        Aluno a = this.alunos.get(codAluno);
        return (a == null) ? null: a.clone();
    }
    
    public void removeAluno(String codAluno)
    {
        this.alunos.remove(codAluno);   
    }

 /* public Set<String> todosOsCodigos()
    {
        return new HashSet<>(this.alunos.keySet());
    } 

    Podes fazer das duas maneiras 
*/
    public Set<String> todosOsCodigos()
    {
        Set<String> numeros = new HashSet<>();
        numeros.addAll(this.alunos.keySet());
        return numeros;
    }

    public int qtsAlunos()
    {
        return this.alunos.size();
    }

    public Collection<Aluno> alunosPorOrdemAlfabetica()
    {
        return this.alunos.values().stream().map((Aluno c) -> (Aluno)c.clone())
        .sorted(Comparator.comparing(c -> c.getNome()))
        .collect(Collectors.toList());
    }
/* 
        INCOMPLETAAAAAAAAAAAAA
    public Set<Aluno> alunosOrdemDescrescenteNumero()
    {
        Set<Aluno> alunos = new TreeSet<>();
        alunos.addAll(this.alunos.values().stream().sorted());

        return alunos;
    }
 */

}   
