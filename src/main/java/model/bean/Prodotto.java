package model.bean;

import java.math.BigDecimal;

public class Prodotto {

    private int id;
    private String nome;
    private String descrizione;
    private BigDecimal prezzoAttuale;
    private String immagine;
    private int quantità;
    private String categoria;
    private boolean ricaricabile;

    // Costruttore vuoto (necessario per JavaBean)
    public Prodotto() {
    }

    // Getter e Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public BigDecimal getPrezzoAttuale() {
        return prezzoAttuale;
    }

    public void setPrezzoAttuale(BigDecimal prezzoAttuale) {
        this.prezzoAttuale = prezzoAttuale;
    }

    public String getImmagine() {
        return immagine;
    }

    public void setImmagine(String immagine) {
        this.immagine = immagine;
    }

    public int getQuantità() {
        return quantità;
    }

    public void setQuantità(int quantità) {
        this.quantità = quantità;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public boolean isRicaricabile() {
        return ricaricabile;
    }

    public void setRicaricabile(boolean ricaricabile) {
        this.ricaricabile = ricaricabile;
    }

    // Metodo toString() utile per debug
    @Override
    public String toString() {
        return "Prodotto{" +
                "id=" + id +
                ", nome='" + nome + '\'' +
                ", descrizione='" + descrizione + '\'' +
                ", prezzoAttuale=" + prezzoAttuale +
                ", immagine='" + immagine + '\'' +
                ", quantità=" + quantità +
                ", categoria='" + categoria + '\'' +
                ", ricaricabile=" + ricaricabile +
                '}';
    }
}