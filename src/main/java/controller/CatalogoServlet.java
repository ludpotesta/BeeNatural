package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import model.bean.Prodotto;
import model.dao.ProdottoDAO;
import model.utils.DBManager;

@WebServlet("/CatalogoServlet")
public class CatalogoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection con = DBManager.getConnection()) {
            ProdottoDAO prodottoDAO = new ProdottoDAO(con);
            List<Prodotto> prodotti = prodottoDAO.doRetrieveAll();

            request.setAttribute("prodotti", prodotti);
            request.getRequestDispatcher("/WEB-INF/catalogo.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore durante il recupero del catalogo");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }
}