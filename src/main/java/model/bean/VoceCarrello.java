package model.bean;

public class VoceCarrello {
    private Prodotto prodotto;
    private int quantita;

    public VoceCarrello(Prodotto prodotto, int quantita) {
        this.prodotto = prodotto;
        this.quantita = quantita;
    }

    public Prodotto getProdotto() {
        return prodotto;
    }
    
    public void setQuantita(int quantita) {
        this.quantita = quantita;
    }
    
    public int getQuantita() {
        return quantita;
    }

    public void incrementaQuantita(int qta) {
        this.quantita += qta;
    }
}