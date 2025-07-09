package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.bean.Utente;
import model.dao.UtenteDAO;
import model.utils.EmailSender;
import model.utils.PasswordUtil;

import java.io.IOException;
import java.sql.SQLException;
import java.util.UUID;

@WebServlet(name = "RecuperaPasswordServlet", value = "/recupera-password")
public class RecuperaPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        try {
            UtenteDAO utenteDAO = new UtenteDAO();
            Utente utente = utenteDAO.doRetrieveByEmail(email);

            if (utente != null) {
                // genera password temporanea
                String tempPassword = UUID.randomUUID().toString().substring(0, 8);
                String hashed = PasswordUtil.hashPassword(tempPassword);

                boolean aggiornata = utenteDAO.aggiornaPasswordByEmail(email, hashed);

                if (aggiornata) {
                    EmailSender.inviaEmail(email, "Recupero Password",
                            "La tua nuova password temporanea è: " + tempPassword);

                    // ✅ salva utente in sessione per reindirizzarlo
                    HttpSession session = request.getSession();
                    utente.setPassword(hashed); // aggiorna anche in oggetto
                    session.setAttribute("utente", utente);

                    // ✅ reindirizza a modifica-password.jsp con flag recupero
                    response.sendRedirect("views/modifica-password.jsp?recupero=true");
                    return;
                } else {
                    request.setAttribute("errore", "Errore durante l'aggiornamento della password");
                }
            } else {
                request.setAttribute("errore", "Email non trovata");
            }

            request.getRequestDispatcher("/views/recupera-password.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("views/error.jsp");
        }
    }
}