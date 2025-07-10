<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="model.bean.Carrello, model.bean.VoceCarrello" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Il tuo Carrello</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/carrello.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"/>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<jsp:include page="/views/include/barra-utente.jsp" />

<div class="container mt-4">
    <h2 class="section-title">Il tuo Carrello</h2>

    <%
        Boolean isGuest = (Boolean) session.getAttribute("isGuest");
        Carrello carrello = (Carrello) session.getAttribute("carrello");

        if (carrello == null || carrello.getProdotti().isEmpty()) {
    %>
        <p>Il carrello è vuoto.</p>
    <%
        } else {
    %>

    <% if (isGuest != null && isGuest) { %>
        <div class="alert alert-warning">Registrati o accedi per completare l'acquisto.</div>
    <% } else { %>

    <form method="post" action="<%= request.getContextPath() %>/AggiornaCarrelloServlet">
        <table class="table custom-table">
            <thead>
                <tr>
                    <th>Prodotto</th>
                    <th>Quantità</th>
                    <th>Prezzo unitario</th>
                    <th>Totale</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    for (VoceCarrello voce : carrello.getProdotti()) {
                        int id = voce.getProdotto().getId();
                        double prezzo = voce.getProdotto().getPrezzoAttuale().doubleValue();
                        int quantita = voce.getQuantita();
                        int disponibile = voce.getProdotto().getQuantità();
                        double totale = prezzo * quantita;
                %>
                <tr>
                    <td><%= voce.getProdotto().getNome() %></td>
                    <td>
                        <input type="hidden" name="idProdotto" value="<%= id %>"/>
                        <input type="number" name="quantita" value="<%= quantita %>" min="0" max="<%= disponibile %>" class="form-control"/>
                        <% if (quantita > disponibile) { %>
                            <div class="errore-quantita">Disponibili: <%= disponibile %></div>
                        <% } %>
                    </td>
                    <td>€ <%= String.format("%.2f", prezzo) %></td>
                    <td>€ <%= String.format("%.2f", totale) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <p class="totale-carrello"><strong>Totale: € <%= String.format("%.2f", carrello.getTotale()) %></strong></p>

        <div class="azioni-carrello">
            <button type="submit" class="btn btn-update">Aggiorna carrello</button>
            <a href="<%= request.getContextPath() %>/views/checkout.jsp" class="btn btn-checkout">Procedi al checkout</a>
        </div>
    </form>

    <% } %>

<% } %>
</div>

</body>
</html>