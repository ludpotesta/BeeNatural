package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.bean.Prodotto;
import model.dao.ProdottoDAO;
import model.utils.DBManager;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;

@WebServlet("/ModificaProdottoServlet")
public class ModificaProdottoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            String descrizione = request.getParameter("descrizione");
            BigDecimal prezzo = new BigDecimal(request.getParameter("prezzo"));
            String categoria = request.getParameter("categoria");
            int quantita = Integer.parseInt(request.getParameter("quantita"));
            String immagine = request.getParameter("immagine");
            boolean ricaricabile = request.getParameter("ricaricabile") != null;

            Prodotto p = new Prodotto();
            p.setId(id);
            p.setNome(nome);
            p.setDescrizione(descrizione);
            p.setPrezzoAttuale(prezzo);
            p.setCategoria(categoria);
            p.setQuantità(quantita);
            p.setImmagine(immagine);
            p.setRicaricabile(ricaricabile);

            try (Connection con = DBManager.getConnection()) {
                ProdottoDAO prodottoDAO = new ProdottoDAO(con);
                prodottoDAO.doUpdate(p);
            }

            response.sendRedirect(request.getContextPath() + "/admin/gestione-prodotti");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/error.jsp");
        }
    }
}