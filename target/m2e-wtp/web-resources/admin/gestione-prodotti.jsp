<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.bean.Prodotto" %>
<jsp:include page="/views/include/barra-utente.jsp" />

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione Prodotti</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/gestione-prodotti.css">
</head>
<body>
<div class="container">
    <h1 class="section-title">Gestione Prodotti</h1>

    <a class="add-product-btn" href="<%= request.getContextPath() %>/admin/aggiungi-prodotto.jsp">+ Aggiungi Prodotto</a>

    <div class="table-wrapper">
        <table class="product-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Prezzo</th>
                <th>Categoria</th>
                <th>Quantità</th>
                <th>Azioni</th>
            </tr>
            </thead>
            <tbody>
            <%
                Object obj = request.getAttribute("prodotti");
                List<Prodotto> prodotti = new java.util.ArrayList<>();
                if (obj instanceof List<?>) {
                    for (Object o : (List<?>) obj) {
                        if (o instanceof Prodotto) {
                            prodotti.add((Prodotto) o);
                        }
                    }
                }

                for (Prodotto p : prodotti) {
            %>
            <tr>
                <td><%= p.getId() %></td>
                <td><%= p.getNome() %></td>
                <td><%= String.format("%.2f", p.getPrezzoAttuale()) %> €</td>
                <td><%= p.getCategoria() %></td>
                <td><%= p.getQuantità() %></td>
                <td class="azioni">
    				<form action="<%= request.getContextPath() %>/admin/modifica-prodotto.jsp" method="get" style="margin: 0;">
        				<input type="hidden" name="id" value="<%= p.getId() %>">
        				<button type="submit" class="modifica-btn">Modifica</button>
    				</form>
    				<form action="<%= request.getContextPath() %>/EliminaProdottoServlet" method="post" onsubmit="return confirm('Sei sicuro di voler eliminare questo prodotto?')" style="margin: 0;">
        				<input type="hidden" name="id" value="<%= p.getId() %>">
        				<button type="submit" class="elimina-btn">Elimina</button>
    				</form>
				</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>