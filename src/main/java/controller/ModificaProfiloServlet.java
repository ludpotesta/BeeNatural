package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.bean.Utente;
import model.dao.UtenteDAO;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "ModificaProfiloServlet", value = "/modifica-profilo")
public class ModificaProfiloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente utente = (Utente) session.getAttribute("utente");

        if (utente != null) {
            request.setAttribute("utente", utente);
            request.getRequestDispatcher("/views/modifica-profilo.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String indirizzo = request.getParameter("indirizzo");
        String telefono = request.getParameter("telefono");

        utente.setNome(nome);
        utente.setCognome(cognome);
        utente.setEmail(email);
        utente.setIndirizzo(indirizzo);
        utente.setTelefono(telefono);

        try {
            UtenteDAO utenteDAO = new UtenteDAO();
            boolean successo = utenteDAO.aggiornaUtente(utente);

            if (successo) {
                session.setAttribute("utente", utente); // aggiorna sessione
                request.setAttribute("successo", "Profilo aggiornato con successo");
            } else {
                request.setAttribute("errore", "Errore durante l'aggiornamento");
            }

            request.getRequestDispatcher("/views/modifica-profilo.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("views/error.jsp");
        }
    }
}