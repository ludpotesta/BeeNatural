package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.bean.Utente;
import model.dao.UtenteDAO;
import model.utils.PasswordUtil;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            UtenteDAO utenteDAO = new UtenteDAO();
            Utente utente = utenteDAO.doRetrieveByEmail(email);

            if (utente != null && PasswordUtil.checkPassword(password, utente.getPassword())) {
                HttpSession session = request.getSession();
                session.setAttribute("utente", utente);

                // ✅ Reindirizza alla servlet che carica i prodotti
                response.sendRedirect(request.getContextPath() + "/CatalogoServlet");
            } else {
                request.setAttribute("erroreLogin", "Email o password errati");
                request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // oppure loggalo
            request.setAttribute("erroreLogin", "Errore di connessione al database");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}