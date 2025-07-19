package controller;

import model.bean.Ordine;
import model.bean.Utente;
import model.dao.OrdineDAO;
import model.dao.UtenteDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/gestione-ordini")
public class GestioneOrdiniServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utente utente = (Utente) request.getSession().getAttribute("utente");
        if (utente == null || !"admin".equalsIgnoreCase(utente.getRuolo())) {
            response.sendRedirect(request.getContextPath() + "/views/error.jsp");
            return;
        }

        List<Ordine> ordini = OrdineDAO.doRetrieveAll();
        System.out.println("🔍 Ordini trovati: " + ordini.size());

        for (Ordine ordine : ordini) {
            ordine.setDettagli(OrdineDAO.getDettagliByOrdineId(ordine.getId()));
            Utente utenteOrdine = UtenteDAO.doRetrieveById(ordine.getIdUtente());
            ordine.setUtente(utenteOrdine); // <-- aggiunto
        }

        request.setAttribute("ordini", ordini);
        request.getRequestDispatcher("/admin/gestione-ordini.jsp").forward(request, response);
    }
}