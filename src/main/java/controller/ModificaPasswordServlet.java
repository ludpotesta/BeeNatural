package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.bean.Utente;
import model.dao.UtenteDAO;
import model.utils.PasswordUtil;

import java.io.IOException;

@WebServlet(name = "ModificaPasswordServlet", value = "/modifica-password")
public class ModificaPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente utente = (Utente) session.getAttribute("utente");

        if (utente == null) {
            response.sendRedirect("views/login.jsp");
            return;
        }

        boolean recupero = request.getParameter("recupero") != null;

        String vecchiaPassword = request.getParameter("vecchiaPassword");
        String nuovaPassword = request.getParameter("nuovaPassword");
        String confermaPassword = request.getParameter("confermaPassword");

        if (vecchiaPassword == null || nuovaPassword == null || confermaPassword == null) {
            request.setAttribute("errore", "Tutti i campi sono obbligatori.");
            request.getRequestDispatcher("/views/modifica-password.jsp").forward(request, response);
            return;
        }

        // Controllo se le nuove password coincidono
        if (!nuovaPassword.equals(confermaPassword)) {
            request.setAttribute("errore", "Le nuove password non coincidono");
            request.getRequestDispatcher("/views/modifica-password.jsp").forward(request, response);
            return;
        }

        // Se NON è un recupero, controllo la vecchia password
        if (!recupero) {
            if (!PasswordUtil.checkPassword(vecchiaPassword, utente.getPassword())) {
                request.setAttribute("errore", "Password attuale errata");
                request.getRequestDispatcher("/views/modifica-password.jsp").forward(request, response);
                return;
            }
        } else {
            // In caso di recupero, la "vecchia" è in realtà la password temporanea
            if (!PasswordUtil.checkPassword(vecchiaPassword, utente.getPassword())) {
                request.setAttribute("errore", "Password temporanea errata");
                request.getRequestDispatcher("/views/modifica-password.jsp?recupero=true").forward(request, response);
                return;
            }
        }

        boolean esito = UtenteDAO.aggiornaUtenteConPassword(utente, nuovaPassword);

        if (esito) {
            session.invalidate(); // logout obbligatorio
            response.sendRedirect(request.getContextPath() + "/views/login.jsp?msg=Password modificata correttamente");
        } else {
            request.setAttribute("errore", "Errore durante la modifica");
            request.getRequestDispatcher("/views/modifica-password.jsp").forward(request, response);
        }
    }
}