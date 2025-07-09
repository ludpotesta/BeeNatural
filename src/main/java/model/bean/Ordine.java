package model.bean;

import java.sql.Timestamp;
import java.util.List;

public class Ordine {
    private int id;
    private int idUtente;
    private Timestamp data;
    private double totalePagato;
    private String indirizzoSped;
    private String metodoPagamento;
    private List<DettaglioOrdine> dettagli;
    private Utente utente;
    
    public Utente getUtente() { return utente; }
    public void setUtente(Utente utente) { this.utente = utente; }
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdUtente() { return idUtente; }
    public void setIdUtente(int idUtente) { this.idUtente = idUtente; }

    public Timestamp getData() { return data; }
    public void setData(Timestamp data) { this.data = data; }

    public double getTotalePagato() { return totalePagato; }
    public void setTotalePagato(double totalePagato) { this.totalePagato = totalePagato; }

    public String getIndirizzoSped() { return indirizzoSped; }
    public void setIndirizzoSped(String indirizzoSped) { this.indirizzoSped = indirizzoSped; }

    public String getMetodoPagamento() { return metodoPagamento; }
    public void setMetodoPagamento(String metodoPagamento) { this.metodoPagamento = metodoPagamento; }

    public List<DettaglioOrdine> getDettagli() { return dettagli; }
    public void setDettagli(List<DettaglioOrdine> dettagli) { this.dettagli = dettagli; }
    
    private String indirizzoFatturazione;

    public String getIndirizzoFatturazione() {
        return indirizzoFatturazione;
    }

    public void setIndirizzoFatturazione(String indirizzoFatturazione) {
        this.indirizzoFatturazione = indirizzoFatturazione;
    }
}