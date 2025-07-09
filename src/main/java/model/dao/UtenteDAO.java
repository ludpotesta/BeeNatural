package model.dao;

import java.sql.*;
import model.bean.Utente;
import model.utils.DBManager;
import model.utils.PasswordUtil;

public class UtenteDAO {

    public UtenteDAO() {
        // Costruttore vuoto
    }

    public boolean aggiornaPasswordByEmail(String email, String nuovaPasswordHash) {
        String sql = "UPDATE utente SET password = ? WHERE email = ?";
        try (Connection con = DBManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nuovaPasswordHash);
            ps.setString(2, email);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Utente doRetrieveByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM utente WHERE email = ?";
        try (Connection con = DBManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Utente u = new Utente();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setCognome(rs.getString("cognome"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setIndirizzo(rs.getString("indirizzo"));
                u.setTelefono(rs.getString("telefono"));
                u.setRuolo(rs.getString("ruolo"));
                return u;
            }
        }
        return null;
    }

    public static Utente doRetrieveById(int id) {
        String sql = "SELECT * FROM utente WHERE id = ?";
        try (Connection con = DBManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Utente u = new Utente();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setCognome(rs.getString("cognome"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setIndirizzo(rs.getString("indirizzo"));
                u.setTelefono(rs.getString("telefono"));
                u.setRuolo(rs.getString("ruolo"));
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean doSave(Utente utente) throws SQLException {
        String checkSql = "SELECT id FROM utente WHERE email = ?";
        try (Connection con = DBManager.getConnection();
             PreparedStatement checkStmt = con.prepareStatement(checkSql)) {
            checkStmt.setString(1, utente.getEmail());
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                return false;
            }

            String insertSql = "INSERT INTO utente (nome, cognome, email, password, indirizzo, telefono, ruolo) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(insertSql)) {
                ps.setString(1, utente.getNome());
                ps.setString(2, utente.getCognome());
                ps.setString(3, utente.getEmail());
                ps.setString(4, utente.getPassword());
                ps.setString(5, utente.getIndirizzo());
                ps.setString(6, utente.getTelefono());
                ps.setString(7, utente.getRuolo());
                return ps.executeUpdate() == 1;
            }
        }
    }

    public boolean doRegister(Utente utente) throws SQLException {
        return doSave(utente);
    }

    public boolean aggiornaUtente(Utente u) throws SQLException {
        String sql = "UPDATE utente SET nome = ?, cognome = ?, email = ?, indirizzo = ?, telefono = ?, password = ? WHERE id = ?";
        try (Connection con = DBManager.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, u.getNome());
            stmt.setString(2, u.getCognome());
            stmt.setString(3, u.getEmail());
            stmt.setString(4, u.getIndirizzo());
            stmt.setString(5, u.getTelefono());
            stmt.setString(6, u.getPassword());
            stmt.setInt(7, u.getId());
            return stmt.executeUpdate() > 0;
        }
    }

    public static boolean aggiornaUtenteConPassword(Utente u, String nuovaPassword) {
        String sql = "UPDATE utente SET nome = ?, email = ?, password = ? WHERE id = ?";
        try (Connection con = DBManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String hashed = PasswordUtil.hashPassword(nuovaPassword);
            ps.setString(1, u.getNome());
            ps.setString(2, u.getEmail());
            ps.setString(3, hashed);
            ps.setInt(4, u.getId());
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void aggiornaIndirizzo(int idUtente, String nuovoIndirizzo) {
        String sql = "UPDATE utente SET indirizzo = ? WHERE id = ?";
        try (Connection con = DBManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nuovoIndirizzo);
            ps.setInt(2, idUtente);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}