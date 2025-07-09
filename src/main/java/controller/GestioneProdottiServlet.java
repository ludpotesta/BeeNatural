package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.bean.Prodotto;
import model.bean.Utente;
import model.dao.ProdottoDAO;
import model.utils.DBManager;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/admin/gestione-prodotti")
public class GestioneProdottiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente utente = (session != null) ? (Utente) session.getAttribute("utente") : null;

        if (utente == null || !"admin".equalsIgnoreCase(utente.getRuolo())) {
            response.sendRedirect(request.getContextPath() + "/views/error.jsp");
            return;
        }

        try (Connection con = DBManager.getConnection()) {
            ProdottoDAO prodottoDAO = new ProdottoDAO(con);
            List<Prodotto> prodotti = prodottoDAO.doRetrieveAll();
            request.setAttribute("prodotti", prodotti);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/gestione-prodotti.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/error.jsp");
        }
    }
}