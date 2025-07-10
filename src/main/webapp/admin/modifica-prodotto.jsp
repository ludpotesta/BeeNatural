<%@ page import="java.sql.SQLException" %>
<%@ page import="model.dao.ProdottoDAO" %>
<%@ page import="model.bean.Prodotto" %>
<%@ page import="model.bean.Utente" %>
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
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
        }
    }

    if (prodotto == null) {
        response.sendRedirect(request.getContextPath() + "/GestioneProdottiServlet");
        return;
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/views/include/barra-utente.jsp" />

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Modifica Prodotto</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modifica-prodotto.css">
</head>
<body>
    <div class="form-container">
        <h1>Modifica Prodotto: <%= prodotto.getNome() %></h1>

        <form action="${pageContext.request.contextPath}/ModificaProdottoServlet" method="post">
            <input type="hidden" name="id" value="<%= prodotto.getId() %>">

            <div class="form-group">
                <label for="nome">Nome Prodotto:</label>
                <input type="text" id="nome" name="nome" class="form-control" 
                       value="<%= prodotto.getNome() %>" required>
            </div>

            <div class="form-group">
                <label for="descrizione">Descrizione:</label>
                <textarea id="descrizione" name="descrizione" class="form-control" 
                          rows="4"><%= prodotto.getDescrizione() != null ? prodotto.getDescrizione() : "" %></textarea>
            </div>

            <div class="form-group">
                <label for="prezzo">Prezzo (€):</label>
                <input type="number" id="prezzo" name="prezzo" class="form-control" 
                       step="0.01" min="0" value="<%= prodotto.getPrezzoAttuale() %>" required>
            </div>

            <div class="form-group">
                <label for="categoria">Categoria:</label>
                <select id="categoria" name="categoria" class="form-control" required>
                    <option value="Skincare" <%= "Skincare".equals(prodotto.getCategoria()) ? "selected" : "" %>>Skincare</option>
                    <option value="Makeup" <%= "Makeup".equals(prodotto.getCategoria()) ? "selected" : "" %>>Makeup</option>
                    <option value="Corpo" <%= "Corpo".equals(prodotto.getCategoria()) ? "selected" : "" %>>Corpo</option>
                    <option value="Capelli" <%= "Capelli".equals(prodotto.getCategoria()) ? "selected" : "" %>>Capelli</option>
                    <option value="Profumi" <%= "Profumi".equals(prodotto.getCategoria()) ? "selected" : "" %>>Profumi</option>
                </select>
            </div>

            <div class="form-group">
                <label for="quantita">Quantità:</label>
                <input type="number" id="quantita" name="quantita" class="form-control" 
                       min="0" value="<%= prodotto.getQuantità() %>" required>
            </div>

            <div class="form-group">
                <label for="immagine">Percorso immagine (es: images/prodotti/nome.jpg):</label>
                <input type="text" id="immagine" name="immagine" class="form-control" 
                       value="<%= prodotto.getImmagine() != null ? prodotto.getImmagine() : "" %>">
            </div>

            <div class="form-group checkbox">
                <label for="ricaricabile">
                    <input type="checkbox" id="ricaricabile" name="ricaricabile" 
                           <%= prodotto.isRicaricabile() ? "checked" : "" %>>
                    Prodotto Ricaricabile
                </label>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Salva Modifiche</button>
                <a href="${pageContext.request.contextPath}/admin/gestione-prodotti" class="btn btn-danger">Annulla</a>
            </div>
        </form>
    </div>
</body>
</html>