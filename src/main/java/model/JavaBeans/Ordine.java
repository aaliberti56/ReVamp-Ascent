package model.JavaBeans;

import java.sql.Time;
import java.util.GregorianCalendar;

public class Ordine {
    private int id_ordine;
    private int num_articoli;
    private String fattura;
    private GregorianCalendar data;
    private double importo_totale;
    private Time orario_ritiro;
    private String punto_ritiro;
    private String info_corriere;
    private int id_indirizzo;
    private String nome_utente;

    public Ordine(int id_ordine, int num_articoli, String fattura, GregorianCalendar data, double importo_totale,
                  Time orario_ritiro, String punto_ritiro, String info_corriere, int id_indirizzo, String nome_utente) {
        this.id_ordine = id_ordine;
        this.num_articoli = num_articoli;
        this.fattura = fattura;
        this.data = data;
        this.importo_totale = importo_totale;
        this.orario_ritiro = orario_ritiro;
        this.punto_ritiro = punto_ritiro;
        this.info_corriere = info_corriere;
        this.id_indirizzo = id_indirizzo;
        this.nome_utente = nome_utente;
    }

    // Getter e setter
    public int getId_ordine() {
        return id_ordine;
    }

    public void setId_ordine(int id_ordine) {
        this.id_ordine = id_ordine;
    }

    public int getNum_articoli() {
        return num_articoli;
    }

    public void setNum_articoli(int num_articoli) {
        this.num_articoli = num_articoli;
    }

    public String getFattura() {
        return fattura;
    }

    public void setFattura(String fattura) {
        this.fattura = fattura;
    }

    public GregorianCalendar getData() {
        return data;
    }

    public void setData(GregorianCalendar data) {
        this.data = data;
    }

    public double getImporto_totale() {
        return importo_totale;
    }

    public void setImporto_totale(double importo_totale) {
        this.importo_totale = importo_totale;
    }

    public Time getOrario_ritiro() {
        return orario_ritiro;
    }

    public void setOrario_ritiro(Time orario_ritiro) {
        this.orario_ritiro = orario_ritiro;
    }

    public String getPunto_ritiro() {
        return punto_ritiro;
    }

    public void setPunto_ritiro(String punto_ritiro) {
        this.punto_ritiro = punto_ritiro;
    }

    public String getInfo_corriere() {
        return info_corriere;
    }

    public void setInfo_corriere(String info_corriere) {
        this.info_corriere = info_corriere;
    }

    public int getId_indirizzo() {
        return id_indirizzo;
    }

    public void setId_indirizzo(int id_indirizzo) {
        this.id_indirizzo = id_indirizzo;
    }

    public String getNome_utente() {
        return nome_utente;
    }

    public void setNome_utente(String nome_utente) {
        this.nome_utente = nome_utente;
    }
}