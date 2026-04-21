import java.util.Map;
import java.util.stream.Collectors;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;


public class TurmaAlunos {
    private String Turma;
    private String UC;
    private Map<String,Aluno> alunos;

    public TurmaAlunos()
    {
        this.Turma = "";
        this.UC = "";
        this.alunos = new HashMap<>();
    }

    public TurmaAlunos(String nome, String uc, Map<String,Aluno> alunos)
    {
        this.Turma = nome;
        this.UC = uc;
        setAlunos(alunos);
    }

    public TurmaAlunos(TurmaAlunos umaTurma)
    {
        this.Turma = umaTurma.getNomeTurma();
        this.UC = umaTurma.getUC();
        this.alunos = umaTurma.getAlunos();
    }

    public String getNomeTurma()
    {
        return Turma;

    }
    
    public void setNomeTurma(String turma)
    {
        this.Turma = turma;
    }

    public String getUC()
    {
        return UC;
    }

    public void setUC(String uc)
    {
        this.UC = uc;
    }

    public Map<String,Aluno> getAlunos()
    {
        return this.alunos.values().stream().collect(Collectors.toMap(Aluno::getNumero, Aluno::clone));
    }

    public void setAlunos(Map<String, Aluno> Novosalunos)
    {
        this.alunos = Novosalunos.values().stream().collect(Collectors.toMap(Aluno::getNumero, Aluno::clone));
    }

    
    
    
}
