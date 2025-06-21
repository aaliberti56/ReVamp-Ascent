package model.JavaBeans;

public class Articolo{
    private int codice;
    private String nome;
    private String descrizione;
    private String colore;
    private double sconto;
    private double prezzo;
    private double peso;
    private String dimensione;



    public Articolo(int codice,String nome,String descrizione,String colore,double sconto,double prezzo,double peso,String dimensione) {
        this.codice = codice;
        this.nome = nome;
        this.descrizione = descrizione;
        this.colore = colore;
        this.sconto = sconto;
        this.prezzo = prezzo;
        this.peso = peso;
        this.dimensione = dimensione;
    }

    public int getCodice() {
        return codice;
    }

    public void setCodice(int codice) {
        this.codice = codice;
    }


    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }


    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public String getColore() {
        return colore;
    }


    public void setColore(String colore) {
        this.colore = colore;
    }

    public double getSconto() {
        return sconto;
    }

    public void setSconto(double sconto) {
        this.sconto = sconto;
    }

    public double getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(double prezzo) {
        this.prezzo = prezzo;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }

    public String getDimensione() {
        return dimensione;
    }

    public void setDimensione(String dimensione) {
        this.dimensione = dimensione;
    }

}