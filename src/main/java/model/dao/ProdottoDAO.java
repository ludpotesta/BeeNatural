package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.bean.Prodotto;
import model.utils.DBManager;

public class ProdottoDAO {
    private Connection connection;

    public ProdottoDAO() throws SQLException {
        this.connection = DBManager.getConnection();
    }

    public ProdottoDAO(Connection connection) {
        this.connection = connection;
    }

    public List<Prodotto> doRetrieveAll() throws SQLException {
        List<Prodotto> prodotti = new ArrayList<>();
        String sql = "SELECT * FROM prodotto ORDER BY nome";

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                prodotti.add(mapRowToProdotto(rs));
            }
        }
        return prodotti;
    }

    public Prodotto doRetrieveById(int id) throws SQLException {
        String sql = "SELECT * FROM prodotto WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? mapRowToProdotto(rs) : null;
            }
        }
    }

    public Prodotto doRetrieveNomeById(int id) throws SQLException {
        String sql = "SELECT id, nome FROM prodotto WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId(rs.getInt("id"));
                    p.setNome(rs.getString("nome"));
                    return p;
                }
                return null;
            }
        }
    }

    public void doSave(Prodotto prodotto) throws SQLException {
        String sql = "INSERT INTO prodotto (nome, descrizione, prezzo_attuale, immagine, quantità, categoria, ricaricabile) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, prodotto.getNome());
            ps.setString(2, prodotto.getDescrizione());
            ps.setBigDecimal(3, prodotto.getPrezzoAttuale());
            ps.setString(4, prodotto.getImmagine());
            ps.setInt(5, prodotto.getQuantità());
            ps.setString(6, prodotto.getCategoria());
            ps.setBoolean(7, prodotto.isRicaricabile());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    prodotto.setId(rs.getInt(1));
                }
            }
        }
    }

    public void doUpdate(Prodotto prodotto) throws SQLException {
        String sql = "UPDATE prodotto SET nome = ?, descrizione = ?, prezzo_attuale = ?, " +
                     "immagine = ?, quantità = ?, categoria = ?, ricaricabile = ? WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, prodotto.getNome());
            ps.setString(2, prodotto.getDescrizione());
            ps.setBigDecimal(3, prodotto.getPrezzoAttuale());
            ps.setString(4, prodotto.getImmagine());
            ps.setInt(5, prodotto.getQuantità());
            ps.setString(6, prodotto.getCategoria());
            ps.setBoolean(7, prodotto.isRicaricabile());
            ps.setInt(8, prodotto.getId());
            ps.executeUpdate();
        }
    }

    public void doDelete(int id) throws SQLException {
        String sql = "DELETE FROM prodotto WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    private Prodotto mapRowToProdotto(ResultSet rs) throws SQLException {
        Prodotto p = new Prodotto();
        p.setId(rs.getInt("id"));
        p.setNome(rs.getString("nome"));
        p.setDescrizione(rs.getString("descrizione"));
        p.setPrezzoAttuale(rs.getBigDecimal("prezzo_attuale"));
        p.setImmagine(rs.getString("immagine"));
        p.setQuantità(rs.getInt("quantità"));
        p.setCategoria(rs.getString("categoria"));
        p.setRicaricabile(rs.getBoolean("ricaricabile"));
        return p;
    }

    public List<Prodotto> doRetrieveByCategoria(String categoria) throws SQLException {
        List<Prodotto> prodotti = new ArrayList<>();
        String sql = "SELECT * FROM prodotto WHERE categoria = ? ORDER BY nome";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, categoria);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    prodotti.add(mapRowToProdotto(rs));
                }
            }
        }
        return prodotti;
    }

    // 🔽 Metodo per verificare disponibilità prodotto
    public boolean verificaDisponibilita(int idProdotto, int quantitaRichiesta) throws SQLException {
        String sql = "SELECT quantità FROM prodotto WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, idProdotto);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt("quantità") >= quantitaRichiesta;
            }
        }
    }

    // 🔽 Metodo per scalare la quantità
    public boolean scalaQuantita(int idProdotto, int quantitaDaScalare) throws SQLException {
        String sql = "UPDATE prodotto SET quantità = quantità - ? WHERE id = ? AND quantità >= ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, quantitaDaScalare);
            ps.setInt(2, idProdotto);
            ps.setInt(3, quantitaDaScalare);
            return ps.executeUpdate() > 0;
        }
    }
}