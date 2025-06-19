package model.JavaBeans;

public class Categoria{
    private int id_categoria;
    private String tipologia;
    public int codice;

    public Categoria(int id_categoria, String tipologia, int codice) {
        this.id_categoria = id_categoria;
        this.tipologia = tipologia;
        this.codice = codice;
    }

    public int getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(int id_categoria) {
        this.id_categoria = id_categoria;
    }

    public String getTipologia() {
        return tipologia;
    }

    public void setTipologia(String tipologia) {
        this.tipologia = tipologia;
    }

    public int getCodice() {
        return codice;
    }

    public void setCodice(int codice) {
        this.codice=codice;
    }

}