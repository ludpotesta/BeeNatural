package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.bean.Utente;
import model.dao.ProdottoDAO;
import model.utils.DBManager;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/EliminaProdottoServlet")
public class EliminaProdottoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L; 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

        if (utente == null || !"admin".equalsIgnoreCase(utente.getRuolo())) {
            response.sendRedirect(request.getContextPath() + "/views/error.jsp");
            return;
        }

        try (Connection con = DBManager.getConnection()) {
            int id = Integer.parseInt(request.getParameter("id"));
            ProdottoDAO prodottoDAO = new ProdottoDAO(con);
            prodottoDAO.doDelete(id);

            session.setAttribute("messaggio", "Prodotto eliminato con successo");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errore", "Si è verificato un errore: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/views/admin/gestione-prodotti.jsp");
    }
}