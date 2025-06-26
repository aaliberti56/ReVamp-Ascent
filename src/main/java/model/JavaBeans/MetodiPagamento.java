package model.JavaBeans;

import java.util.GregorianCalendar;

public class MetodiPagamento{
    private String numCarta;
    private String intestatario;
    private GregorianCalendar dataScadenza;
    private int cvv;
    private String nomeUtente;


    public MetodiPagamento(String numCarta, String intestatario, GregorianCalendar dataScadenza, int cvv, String nomeUtente) {
        this.numCarta = numCarta;
        this.intestatario = intestatario;
        this.dataScadenza = dataScadenza;
        this.cvv = cvv;
        this.nomeUtente = nomeUtente;
    }

    public String getNumCarta() {
        return numCarta;
    }

    public void setNumCarta(String numCarta) {
        this.numCarta = numCarta;
    }

    public String getIntestatario() {
        return intestatario;
    }

    public void setIntestatario(String intestatario) {
        this.intestatario = intestatario;
    }

    public GregorianCalendar getDataScadenza() {
        return dataScadenza;
    }

    public void setDataScadenza(GregorianCalendar dataScadenza) {
        this.dataScadenza = dataScadenza;
    }

    public int getCvv() {
        return cvv;
    }

    public void setCvv(int cvv) {
        this.cvv = cvv;
    }

    public String getNomeUtente() {
        return nomeUtente;
    }

    public void setNomeUtente(String nomeUtente) {
        this.nomeUtente = nomeUtente;
    }
}
