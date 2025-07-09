package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

import model.bean.Carrello;

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

            for (int i = 0; i < idProdotti.length; i++) {
                try {
                    int id = Integer.parseInt(idProdotti[i]);
                    int quantita = Integer.parseInt(quantitaStr[i]);

                    if (quantita <= 0) {
                        carrello.rimuoviProdotto(id);
                    } else {
                        carrello.aggiornaQuantita(id, quantita);
                    }
                } catch (NumberFormatException ignored) {}
            }
        }

        response.sendRedirect(request.getContextPath() + "/views/carrello.jsp");
    }
}