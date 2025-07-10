<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="model.bean.Carrello, model.bean.VoceCarrello" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Il tuo Carrello</title>
    <style>
        .btn {
            padding: 8px 15px;
            margin-top: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }

        .errore-quantita {
            color: red;
            font-size: 0.9em;
        }
    </style>
</head>
<body>

<jsp:include page="/views/include/barra-utente.jsp" />

<h1>Il tuo carrello</h1>

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
        <p>Registrati o accedi per completare l'acquisto.</p>
    <% } else { %>

    <!-- FORM per aggiornare le quantità -->
    <form method="post" action="<%= request.getContextPath() %>/AggiornaCarrelloServlet">
        <table>
            <thead>
                <tr>
                    <th>Nome</th>
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
                        <input type="number" name="quantita" value="<%= quantita %>" min="0" max="<%= disponibile %>"/>
                        <% if (quantita > disponibile) { %>
                            <div class="errore-quantita">
                                Disponibili: <%= disponibile %>
                            </div>
                        <% } %>
                    </td>
                    <td>€ <%= String.format("%.2f", prezzo) %></td>
                    <td>€ <%= String.format("%.2f", totale) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <p><strong>Totale: € <%= String.format("%.2f", carrello.getTotale()) %></strong></p>
        <button type="submit" class="btn">Aggiorna carrello</button>
    </form>

    <!-- Checkout -->
    <form method="get" action="<%= request.getContextPath() %>/views/checkout.jsp">
        <button type="submit" class="btn">Procedi al checkout</button>
    </form>

    <% } %>

<% } %>

</body>
</html>