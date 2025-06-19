package model;

import java.sql.Time;
import java.sql.Date;
import java.util.GregorianCalendar;

public class Ordine{
    public int id_ordine;
    public int num_articoli;
    private String fattura;
    private GregorianCalendar data;
    private double importo_totale;
    private Time orario_ritiro;
    private String punto_ritiro;
    private String info_corriere;
    private String indirizzo_consegna;
    private String nome_utente;

    public Ordine(int id_ordine, int num_articoli, String fattura, GregorianCalendar data, double importo_totale, Time orario_ritiro, String punto_ritiro, String info_corriere, String indirizzo_consegna, String nome_utente) {
        this.id_ordine = id_ordine;
        this.num_articoli = num_articoli;
        this.fattura = fattura;
        this.data = data;
        this.importo_totale = importo_totale;
        this.orario_ritiro = orario_ritiro;
        this.punto_ritiro = punto_ritiro;
        this.info_corriere = info_corriere;
        this.indirizzo_consegna = indirizzo_consegna;
        this.nome_utente = nome_utente;
    }

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

    public String getIndirizzo_consegna() {
        return indirizzo_consegna;
    }

    public void setIndirizzo_consegna(String indirizzo_consegna) {
        this.indirizzo_consegna = indirizzo_consegna;
    }

    public String getNome_utente() {
        return nome_utente;
    }
    public void setNome_utente(String nome_utente) {
        this.nome_utente = nome_utente;
    }


}