package model.bean;

public class DettaglioOrdine {
    private int id;
    private int idOrdine;
    private int idProdotto;
    private int quantita;
    private double prezzoPagato;
    private String nomeProdotto;
    private String descrizioneProdotto;
    private String immagineProdotto;

    public String getDescrizioneProdotto() {
        return descrizioneProdotto;
    }

    public void setDescrizioneProdotto(String descrizioneProdotto) {
        this.descrizioneProdotto = descrizioneProdotto;
    }

    public String getImmagineProdotto() {
        return immagineProdotto;
    }

    public void setImmagineProdotto(String immagineProdotto) {
        this.immagineProdotto = immagineProdotto;
    }
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdOrdine() { return idOrdine; }
    public void setIdOrdine(int idOrdine) { this.idOrdine = idOrdine; }

    public int getIdProdotto() { return idProdotto; }
    public void setIdProdotto(int idProdotto) { this.idProdotto = idProdotto; }

    public int getQuantita() { return quantita; }
    public void setQuantita(int quantita) { this.quantita = quantita; }

    public double getPrezzoPagato() { return prezzoPagato; }
    public void setPrezzoPagato(double prezzoPagato) { this.prezzoPagato = prezzoPagato; }

    public String getNomeProdotto() { return nomeProdotto; }
    public void setNomeProdotto(String nomeProdotto) { this.nomeProdotto = nomeProdotto; }
}