package model;

import java.util.GregorianCalendar;

public class Pagamento {
    private int id_pagamento;
    private GregorianCalendar data_pagamento;
    private double importo;
    private String metodo_pagamento;
    private String stato_pagamento;
    private int id_ordine;

    // Costruttore pieno
    public Pagamento(int id_pagamento, GregorianCalendar data_pagamento, double importo,String metodo_pagamento, String stato_pagamento, int id_ordine) {
        this.id_pagamento = id_pagamento;
        this.data_pagamento = data_pagamento;
        this.importo = importo;
        this.metodo_pagamento = metodo_pagamento;
        this.stato_pagamento = stato_pagamento;
        this.id_ordine = id_ordine;
    }

    // Getter e Setter
    public int getId_pagamento() {
        return id_pagamento;
    }

    public void setId_pagamento(int id_pagamento) {
        this.id_pagamento = id_pagamento;
    }

    public GregorianCalendar getData_pagamento() {
        return data_pagamento;
    }

    public void setData_pagamento(GregorianCalendar data_pagamento) {
        this.data_pagamento = data_pagamento;
    }

    public double getImporto() {
        return importo;
    }

    public void setImporto(double importo) {
        this.importo = importo;
    }

    public String getMetodo_pagamento() {
        return metodo_pagamento;
    }

    public void setMetodo_pagamento(String metodo_pagamento) {
        this.metodo_pagamento = metodo_pagamento;
    }

    public String getStato_pagamento() {
        return stato_pagamento;
    }

    public void setStato_pagamento(String stato_pagamento) {
        this.stato_pagamento = stato_pagamento;
    }

    public int getId_ordine() {
        return id_ordine;
    }

    public void setId_ordine(int id_ordine) {
        this.id_ordine = id_ordine;
    }
}

