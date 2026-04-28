/**
 * Classe Aluno.
 * Classe que modela de forma muito simples a
 * informação e comportamento relevante de um aluno.
 * 
 * @author MaterialPOO
 * @version 20200216
 */
public class Aluno {

  private String numero;
  private int nota;
  private String nome;
  private String curso;

  /**
   * Constructores para a classe Aluno
   */
  public Aluno() {
    this.numero = "";
    this.nota = 0;
    this.nome = "";
    this.curso = "";
  }

  public Aluno(String numero, int nota, String nome, String curso) {
    this.numero = numero;
    this.nota = nota;
    this.nome = nome;
    this.curso = curso;
  }

  public Aluno(Aluno umAluno) {
    this.numero = umAluno.getNumero();
    this.nota = umAluno.getNota();
    this.nome = umAluno.getNome();
    this.curso = umAluno.getCurso();
  }

  /**
   * Método que devolve o número de um aluno.
   * 
   * @return String com o número do aluno
   */
  public String getNumero() {
    return this.numero;
  }

  /**
   * Método que devolve a nota de um aluno.
   * 
   * @return int com o número do aluno
   */
  public int getNota() {
    return this.nota;
  }

  /**
   * Método que devolve o nome de um aluno.
   * 
   * @return String com o nome do aluno
   */
  public String getNome() {
    return this.nome;
  }

  /**
   * Método que devolve o curso de um aluno.
   * 
   * @return String com o número do aluno
   */
  public String getCurso() {
    return this.curso;
  }

  public void setNota(int novaNota) {
    this.nota = novaNota;
  }

  public void setNumero(String numero) {
    this.numero = numero;
  }

  public void setNome(String nome) {
    this.nome = nome;
  }

  public void setCurso(String curso) {
    this.curso = curso;
  }

  public String toString() {
    StringBuffer sb = new StringBuffer();

    sb.append("Numero: ");
    sb.append(this.numero + " - ");
    sb.append("Nome: ");
    sb.append(this.nome);

    return sb.toString();

  }

  public boolean equals(Object o) {
    if (this == o)
      return true;

    if ((o == null) || (this.getClass() != o.getClass()))
      return false;

    Aluno umAluno = (Aluno) o;
    return (this.nome.equals(umAluno.getNome()) && this.nota == umAluno.getNota()
        && this.numero.equals(umAluno.getNumero())
        && this.curso.equals(umAluno.getCurso()));
  }

  public Aluno clone() {
    return new Aluno(this);
  }

}
