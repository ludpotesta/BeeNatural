package model.bean;

import java.math.BigDecimal;
import java.util.*;

public class Carrello {
    private Map<Integer, VoceCarrello> prodotti = new HashMap<>();

    public void aggiungiProdotto(Prodotto prodotto, int quantita) {
        int id = prodotto.getId();
        if (prodotti.containsKey(id)) {
            prodotti.get(id).incrementaQuantita(quantita);
        } else {
            prodotti.put(id, new VoceCarrello(prodotto, quantita));
        }
    }

    public void aggiornaQuantita(int idProdotto, int quantita) {
        if (prodotti.containsKey(idProdotto)) {
            prodotti.get(idProdotto).setQuantita(quantita);
        }
    }

    public void rimuoviProdotto(int idProdotto) {
        prodotti.remove(idProdotto);
    }

    public Collection<VoceCarrello> getProdotti() {
        return prodotti.values();
    }

    public void svuota() {
        prodotti.clear();
    }

    public BigDecimal getTotale() {
        return prodotti.values().stream()
            .map(v -> v.getProdotto().getPrezzoAttuale().multiply(BigDecimal.valueOf(v.getQuantita())))
            .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public int getNumeroProdottiTotale() {
        return prodotti.values().stream()
            .mapToInt(VoceCarrello::getQuantita)
            .sum();
    }
}