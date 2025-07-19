package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.*;

import model.bean.*;
import model.dao.OrdineDAO;

public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if (session.getAttribute("utente") == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        request.getRequestDispatcher("/views/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");
        Carrello carrello = (Carrello) session.getAttribute("carrello");

        if (utente == null || carrello == null || carrello.getProdotti().isEmpty()) {
            response.sendRedirect("error.jsp");
            return;
        }

        String indirizzoSped = request.getParameter("indirizzoSped");
        String cittaSped = request.getParameter("cittaSped");
        String capSped = request.getParameter("capSped");
        String statoSped = request.getParameter("statoSped");

        String indirizzoFatt = request.getParameter("indirizzoFatt");
        String cittaFatt = request.getParameter("cittaFatt");
        String capFatt = request.getParameter("capFatt");
        String statoFatt = request.getParameter("statoFatt");

        String metodoPagamento = request.getParameter("metodoPagamento");

        String indirizzoSpedCompleto = indirizzoSped + ", " + cittaSped + ", " + capSped + ", " + statoSped;
        String indirizzoFattCompleto = indirizzoFatt + ", " + cittaFatt + ", " + capFatt + ", " + statoFatt;

        if (!indirizzoSpedCompleto.equals(utente.getIndirizzo())) {
            utente.setIndirizzo(indirizzoSpedCompleto);
            model.dao.UtenteDAO.aggiornaIndirizzo(utente.getId(), indirizzoSpedCompleto);
            session.setAttribute("utente", utente);
        }

        Ordine ordine = new Ordine();
        ordine.setIdUtente(utente.getId());
        ordine.setData(new Timestamp(System.currentTimeMillis()));
        ordine.setTotalePagato(carrello.getTotale().doubleValue());
        ordine.setIndirizzoSped(indirizzoSpedCompleto);
        ordine.setMetodoPagamento(metodoPagamento);
        ordine.setIndirizzoFatturazione(indirizzoFattCompleto);

        List<DettaglioOrdine> dettagli = new ArrayList<>();
        for (VoceCarrello voce : carrello.getProdotti()) {
            DettaglioOrdine d = new DettaglioOrdine();
            d.setIdProdotto(voce.getProdotto().getId());
            d.setQuantita(voce.getQuantita());
            d.setPrezzoPagato(voce.getProdotto().getPrezzoAttuale().doubleValue());
            dettagli.add(d);
        }
        ordine.setDettagli(dettagli);

        int idOrdine = OrdineDAO.salvaOrdine(ordine);

        session.removeAttribute("carrello");
        request.setAttribute("idOrdine", idOrdine);
        request.getRequestDispatcher("/views/checkout-success.jsp").forward(request, response);
    }
}