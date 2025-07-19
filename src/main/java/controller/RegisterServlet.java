package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.bean.Utente;
import model.dao.UtenteDAO;
import model.utils.PasswordUtil;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "RegisterServlet", value = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String indirizzo = request.getParameter("indirizzo");
        String telefono = request.getParameter("telefono");

        Utente utente = new Utente();
        utente.setNome(nome);
        utente.setCognome(cognome);
        utente.setEmail(email);
        utente.setPassword(PasswordUtil.hashPassword(password));
        utente.setIndirizzo(indirizzo);
        utente.setTelefono(telefono);
        utente.setRuolo("cliente"); 

        try {
            UtenteDAO utenteDAO = new UtenteDAO();
            boolean registrato = utenteDAO.doSave(utente);
            
            if (registrato) {
                response.sendRedirect("views/login.jsp");
            } else {
                request.setAttribute("erroreRegistrazione", "Errore durante la registrazione");
                request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
            request.setAttribute("erroreRegistrazione", "Errore del database");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        }
    }
}