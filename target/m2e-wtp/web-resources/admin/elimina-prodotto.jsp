<%@ page import="model.bean.Utente" %>
<%@ page import="model.bean.Prodotto" %>
<%@ page import="model.dao.ProdottoDAO" %>
<%
    // Controllo accesso admin
    Utente utente = (Utente) session.getAttribute("utente");
    if (utente == null || !"admin".equalsIgnoreCase(utente.getRuolo())) {
        response.sendRedirect(request.getContextPath() + "/views/error.jsp");
        return;
    }

    // Recupera il prodotto da eliminare
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

    // Se il prodotto non esiste, reindirizza
    if (prodotto == null) {
        response.sendRedirect(request.getContextPath() + "/views/admin/gestione-prodotti.jsp");
        return;
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/views/include/barra-utente.jsp" />

<!DOCTYPE html>
<html>
<head>
    <title>Conferma Eliminazione Prodotto</title>
    <style>
        .confirmation-container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-align: center;
        }
        .product-info {
            text-align: left;
            margin: 20px 0;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 4px;
        }
        .btn {
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin: 5px;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
    </style>
</head>
<body>
    <div class="confirmation-container">
        <h1>Conferma Eliminazione Prodotto</h1>
        
        <p>Sei sicuro di voler eliminare definitivamente questo prodotto?</p>
        
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
            <button type="submit" class="btn btn-danger">Conferma Eliminazione</button>
            <a href="${pageContext.request.contextPath}/views/admin/gestione-prodotti.jsp" 
               class="btn btn-secondary">Annulla</a>
        </form>
    </div>
</body>
</html>