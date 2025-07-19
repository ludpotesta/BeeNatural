package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import model.bean.Prodotto;
import model.bean.Carrello;
import model.dao.ProdottoDAO;
import model.utils.DBManager;

public class AggiungiAlCarrelloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection con = null;
        try {
            con = DBManager.getConnection();
            int idProdotto = Integer.parseInt(request.getParameter("id"));
            int quantita = Integer.parseInt(request.getParameter("quantita"));

            ProdottoDAO prodottoDAO = new ProdottoDAO(con);
            Prodotto prodotto = prodottoDAO.doRetrieveById(idProdotto);

            if (prodotto != null) {
                if (quantita <= 0 || quantita > prodotto.getQuantità()) {
                    
                    request.setAttribute("erroreCarrello", "Quantità richiesta non disponibile.");
                    request.getRequestDispatcher("/views/error.jsp").forward(request, response);
                    return;
                }

                HttpSession session = request.getSession();
                Carrello carrello = (Carrello) session.getAttribute("carrello");
                if (carrello == null) {
                    carrello = new Carrello();
                    session.setAttribute("carrello", carrello);
                }
                carrello.aggiungiProdotto(prodotto, quantita);
            }

            response.sendRedirect(request.getContextPath() + "/catalogo");
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        } finally {
            if (con != null) {
                try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }
}