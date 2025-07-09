package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.bean.Utente;
import model.dao.OrdineDAO;
import model.bean.Ordine;

import java.io.IOException;
import java.util.List;

public class ProfiloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente utente = (session != null) ? (Utente) session.getAttribute("utente") : null;

        if (utente == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        try {
            // ✅ Chiamata al metodo statico
            List<Ordine> ordini = OrdineDAO.doRetrieveByUtente(utente.getId());
            request.setAttribute("ordiniObj", ordini);
            
            for (Ordine ordine : ordini) {
                ordine.setDettagli(OrdineDAO.getDettagliByOrdineId(ordine.getId()));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore nel recupero degli ordini.");
        }

        // ✅ Nessuna connessione aperta necessaria qui, già gestita nei DAO
        request.getRequestDispatcher("/views/profilo.jsp").forward(request, response);
    }
}