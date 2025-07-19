package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.bean.Utente;
import model.dao.OrdineDAO;

import java.io.IOException;

@WebServlet("/admin/elimina-ordine")
public class EliminaOrdineServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utente utente = (Utente) request.getSession().getAttribute("utente");
        if (utente == null || !"admin".equalsIgnoreCase(utente.getRuolo())) {
            response.sendRedirect(request.getContextPath() + "/views/error.jsp");
            return;
        }

        try {
            int idOrdine = Integer.parseInt(request.getParameter("idOrdine"));
            OrdineDAO.deleteById(idOrdine);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/gestione-ordini");
    }
}