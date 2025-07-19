package model.dao;

import model.bean.Ordine;
import model.bean.Prodotto;
import model.bean.DettaglioOrdine;
import model.utils.DBManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrdineDAO {

	public static int salvaOrdine(Ordine ordine) {
	    int idOrdine = -1;
	    Connection con = null;

	    try {
	        con = DBManager.getConnection();
	        con.setAutoCommit(false); 

	        String sqlOrdine = "INSERT INTO ordine (id_utente, data, totale_pagato, indirizzo_sped, metodo_pagamento, indirizzo_fatturazione) " +
	                         "VALUES (?, ?, ?, ?, ?, ?)";

	        try (PreparedStatement psOrdine = con.prepareStatement(sqlOrdine, Statement.RETURN_GENERATED_KEYS)) {
	            psOrdine.setInt(1, ordine.getIdUtente());
	            psOrdine.setTimestamp(2, ordine.getData());
	            psOrdine.setDouble(3, ordine.getTotalePagato());
	            psOrdine.setString(4, ordine.getIndirizzoSped());
	            psOrdine.setString(5, ordine.getMetodoPagamento());
	            psOrdine.setString(6, ordine.getIndirizzoFatturazione());

	            psOrdine.executeUpdate();

	            try (ResultSet rs = psOrdine.getGeneratedKeys()) {
	                if (rs.next()) {
	                    idOrdine = rs.getInt(1);
	                }
	            }
	        }

	        String sqlDettaglio = "INSERT INTO dettaglioordine (id_ordine, id_prodotto, quantità, prezzo_pagato) " +
	                            "VALUES (?, ?, ?, ?)";
	        try (PreparedStatement psDettaglio = con.prepareStatement(sqlDettaglio)) {

	            ProdottoDAO prodottoDAO = new ProdottoDAO(con);

	            for (DettaglioOrdine d : ordine.getDettagli()) {
	                if (!prodottoDAO.verificaDisponibilita(d.getIdProdotto(), d.getQuantita()) ||
	                    !prodottoDAO.scalaQuantita(d.getIdProdotto(), d.getQuantita())) {
	                    
	                    System.err.println("Quantità non disponibile o non scalata per prodotto ID: " + d.getIdProdotto());
	                    con.rollback();
	                    return -1;
	                }

	                psDettaglio.setInt(1, idOrdine);
	                psDettaglio.setInt(2, d.getIdProdotto());
	                psDettaglio.setInt(3, d.getQuantita());
	                psDettaglio.setDouble(4, d.getPrezzoPagato());
	                psDettaglio.addBatch();
	            }

	            psDettaglio.executeBatch();
	        }

	        con.commit(); 
	        return idOrdine;

	    } catch (SQLException e) {
	        try {
	            if (con != null) con.rollback();
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	        }
	        System.err.println("Errore nel salvataggio ordine: " + e.getMessage());
	        e.printStackTrace();
	        return -1;
	    } finally {
	        try {
	            if (con != null) {
	                con.setAutoCommit(true);
	                con.close();
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}
    
    public static List<Ordine> doRetrieveByUtente(int idUtente) {
        List<Ordine> ordini = new ArrayList<>();
        String sql = "SELECT * FROM ordine WHERE id_utente = ? ORDER BY data DESC";

        try (Connection con = DBManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUtente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ordine ordine = new Ordine();
                    ordine.setId(rs.getInt("id"));
                    ordine.setIdUtente(rs.getInt("id_utente"));
                    ordine.setData(rs.getTimestamp("data"));
                    ordine.setTotalePagato(rs.getDouble("totale_pagato"));
                    ordine.setIndirizzoSped(rs.getString("indirizzo_sped"));
                    ordine.setMetodoPagamento(rs.getString("metodo_pagamento"));
                    ordine.setIndirizzoFatturazione(rs.getString("indirizzo_fatturazione"));
                    ordini.add(ordine);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ordini;
    }
    
    public static List<DettaglioOrdine> getDettagliByOrdineId(int idOrdine) {
        List<DettaglioOrdine> dettagli = new ArrayList<>();
        String sql = "SELECT * FROM dettaglioordine WHERE id_ordine = ?";

        try (Connection con = DBManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idOrdine);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    DettaglioOrdine d = new DettaglioOrdine();
                    d.setId(rs.getInt("id"));
                    d.setIdOrdine(rs.getInt("id_ordine"));
                    d.setIdProdotto(rs.getInt("id_prodotto"));
                    d.setQuantita(rs.getInt("quantità"));
                    d.setPrezzoPagato(rs.getDouble("prezzo_pagato"));

                    ProdottoDAO prodottoDAO = new ProdottoDAO(con);  
                    try {
                        Prodotto prodotto = prodottoDAO.doRetrieveById(d.getIdProdotto());
                        if (prodotto != null) {
                            d.setNomeProdotto(prodotto.getNome());
                            d.setDescrizioneProdotto(prodotto.getDescrizione());
                            d.setImmagineProdotto(prodotto.getImmagine());
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    dettagli.add(d);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dettagli;
    }
    
    public static List<Ordine> doRetrieveAll() {
        List<Ordine> ordini = new ArrayList<>();
        String sql = "SELECT * FROM ordine ORDER BY data DESC";

        try (Connection con = DBManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Ordine ordine = new Ordine();
                ordine.setId(rs.getInt("id"));
                ordine.setIdUtente(rs.getInt("id_utente"));
                ordine.setData(rs.getTimestamp("data"));
                ordine.setTotalePagato(rs.getDouble("totale_pagato"));
                ordine.setIndirizzoSped(rs.getString("indirizzo_sped"));
                ordine.setMetodoPagamento(rs.getString("metodo_pagamento"));
                ordine.setIndirizzoFatturazione(rs.getString("indirizzo_fatturazione"));
                ordini.add(ordine);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ordini;
    }
    
    public static void deleteById(int idOrdine) {
        String deleteDettagli = "DELETE FROM dettaglioordine WHERE id_ordine = ?";
        String deleteOrdine = "DELETE FROM ordine WHERE id = ?";

        try (Connection con = DBManager.getConnection()) {
            con.setAutoCommit(false);

            try (PreparedStatement ps1 = con.prepareStatement(deleteDettagli);
                 PreparedStatement ps2 = con.prepareStatement(deleteOrdine)) {

                ps1.setInt(1, idOrdine);
                ps1.executeUpdate();

                ps2.setInt(1, idOrdine);
                ps2.executeUpdate();

                con.commit();
                System.out.println("✅ Ordine eliminato con successo: ID " + idOrdine);
            } catch (SQLException e) {
                con.rollback();
                System.err.println("❌ Errore durante eliminazione ordine: " + idOrdine);
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}