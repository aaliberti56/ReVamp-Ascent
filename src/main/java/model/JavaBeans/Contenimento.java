package model.JavaBeans;

public class Contenimento {
    private int codice;
    private int id_ordine;
    private int quantita;

    // Costruttore pieno
    public Contenimento(int codice, int id_ordine, int quantita) {
        this.codice = codice;
        this.id_ordine = id_ordine;
        this.quantita = quantita;
    }

    // Getter e Setter
    public int getCodice() {
        return codice;
    }

    public void setCodice(int codice) {
        this.codice = codice;
    }

    public int getId_ordine() {
        return id_ordine;
    }

    public void setId_ordine(int id_ordine) {
        this.id_ordine = id_ordine;
    }

    public int getQuantita() {
        return quantita;
    }

    public void setQuantita(int quantita) {
        this.quantita = quantita;
    }
}
