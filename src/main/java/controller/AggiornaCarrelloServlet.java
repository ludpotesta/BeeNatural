package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import model.bean.Carrello;
import model.dao.ProdottoDAO;
import model.utils.DBManager;

@WebServlet("/AggiornaCarrelloServlet")
public class AggiornaCarrelloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        Carrello carrello = (Carrello) session.getAttribute("carrello");

        if (carrello != null) {
            String[] idProdotti = request.getParameterValues("idProdotto");
            String[] quantitaStr = request.getParameterValues("quantita");

            Connection con = null;

            try {
                con = DBManager.getConnection();
                ProdottoDAO prodottoDAO = new ProdottoDAO(con);

                for (int i = 0; i < idProdotti.length; i++) {
                    try {
                        int id = Integer.parseInt(idProdotti[i]);
                        int quantita = Integer.parseInt(quantitaStr[i]);

                        int disponibile = prodottoDAO.doRetrieveById(id).getQuantità();

                        if (quantita <= 0) {
                            carrello.rimuoviProdotto(id);
                        } else if (quantita > disponibile) {
                            request.setAttribute("erroreCarrello", "La quantità per il prodotto con ID " + id + " supera lo stock disponibile.");
                            request.getRequestDispatcher("/views/carrello.jsp").forward(request, response);
                            return;
                        } else {
                            carrello.aggiornaQuantita(id, quantita);
                        }
                    } catch (NumberFormatException ignored) {}
                }

            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            } finally {
                if (con != null) {
                    try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        }

        response.sendRedirect(request.getContextPath() + "/views/carrello.jsp");
    }
}