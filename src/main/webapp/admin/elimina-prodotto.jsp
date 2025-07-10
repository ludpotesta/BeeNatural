<%@ page import="model.bean.Utente" %>
<%@ page import="model.bean.Prodotto" %>
<%@ page import="model.dao.ProdottoDAO" %>
<%
    Utente utente = (Utente) session.getAttribute("utente");
    if (utente == null || !"admin".equalsIgnoreCase(utente.getRuolo())) {
        response.sendRedirect(request.getContextPath() + "/views/error.jsp");
        return;
    }

    Prodotto prodotto = null;
    String idParam = request.getParameter("id");
    if (idParam != null && !idParam.isEmpty()) {
        try {
            int id = Integer.parseInt(idParam);
            ProdottoDAO prodottoDAO = new ProdottoDAO();
            prodotto = prodottoDAO.doRetrieveById(id);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    if (prodotto == null) {
        response.sendRedirect(request.getContextPath() + "/admin/gestione-prodotti");
        return;
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/views/include/barra-utente.jsp" />

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Conferma Eliminazione Prodotto</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/elimina-prodotto.css">
</head>
<body>
<div class="confirmation-container">
    <h1>Conferma Eliminazione</h1>
    <p class="warning-text">Sei sicuro di voler eliminare definitivamente questo prodotto?</p>

    <div class="product-info">
        <h3><%= prodotto.getNome() %></h3>
        <p><strong>ID:</strong> <%= prodotto.getId() %></p>
        <p><strong>Categoria:</strong> <%= prodotto.getCategoria() %></p>
        <p><strong>Prezzo:</strong> €<%= prodotto.getPrezzoAttuale() %></p>
        <p><strong>Quantità disponibile:</strong> <%= prodotto.getQuantità() %></p>
        <% if (prodotto.getDescrizione() != null && !prodotto.getDescrizione().isEmpty()) { %>
            <p><strong>Descrizione:</strong> <%= prodotto.getDescrizione() %></p>
        <% } %>
    </div>

    <form action="${pageContext.request.contextPath}/EliminaProdottoServlet" method="post">
        <input type="hidden" name="id" value="<%= prodotto.getId() %>">
        <div class="form-buttons">
            <button type="submit" class="btn btn-danger">Conferma Eliminazione</button>
            <a href="${pageContext.request.contextPath}/admin/gestione-prodotti" class="btn btn-secondary">Annulla</a>
        </div>
    </form>
</div>
</body>
</html>