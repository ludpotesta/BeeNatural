package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.bean.Prodotto;
import model.bean.Utente;
import model.dao.ProdottoDAO;
import model.utils.DBManager;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Paths;
import java.sql.Connection;

@WebServlet("/aggiungi-prodotto")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,        // 1MB
    maxFileSize = 1024 * 1024 * 5,          // 5MB
    maxRequestSize = 1024 * 1024 * 10       // 10MB
)
public class AggiungiProdottoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

        if (utente == null || !"admin".equalsIgnoreCase(utente.getRuolo())) {
            response.sendRedirect(request.getContextPath() + "/views/error.jsp");
            return;
        }

        String nome = request.getParameter("nome");
        String descrizione = request.getParameter("descrizione");
        BigDecimal prezzo = new BigDecimal(request.getParameter("prezzo"));
        String categoria = request.getParameter("categoria");
        int quantita = Integer.parseInt(request.getParameter("quantita"));

        Part filePart = request.getPart("immagine");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Pulizia del nome file in caso l'utente inserisca "images/prodotti/nome.jpg"
        fileName = fileName.replaceAll(".*[/\\\\]", ""); // rimuove eventuali path

        String uploadPath = getServletContext().getRealPath("") + "images" + File.separator + "prodotti";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // ✅ Salviamo SOLO il nome del file, non il path
        String immagine = fileName;

        Prodotto prodotto = new Prodotto();
        prodotto.setNome(nome);
        prodotto.setDescrizione(descrizione);
        prodotto.setPrezzoAttuale(prezzo);
        prodotto.setCategoria(categoria);
        prodotto.setQuantità(quantita);
        prodotto.setImmagine(immagine);

        try (Connection con = DBManager.getConnection()) {
            ProdottoDAO prodottoDAO = new ProdottoDAO(con);
            prodottoDAO.doSave(prodotto);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/error.jsp");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin/gestione-prodotti");
    }
}