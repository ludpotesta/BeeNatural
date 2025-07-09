<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.bean.Prodotto" %>
<jsp:include page="/views/include/barra-utente.jsp" />

<h1>Gestione Prodotti</h1>

<a href="<%= request.getContextPath() %>/admin/aggiungi-prodotto.jsp"
   style="display:inline-block; margin-bottom: 15px;">+ Aggiungi Prodotto</a>

<table border="1" style="border-collapse: collapse; width: 100%;">
    <tr>
        <th>ID</th>
        <th>Nome</th>
        <th>Prezzo</th>
        <th>Categoria</th>
        <th>Quantità</th>
        <th>Azioni</th>
    </tr>
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
        <td style="padding: 10px;"><%= p.getId() %></td>
        <td style="padding: 10px;"><%= p.getNome() %></td>
        <td style="padding: 10px;"><%= p.getPrezzoAttuale() %> €</td>
        <td style="padding: 10px;"><%= p.getCategoria() %></td>
        <td style="padding: 10px;"><%= p.getQuantità() %></td>
        <td style="padding: 10px;">
            <a href="<%= request.getContextPath() %>/admin/modifica-prodotto.jsp?id=<%= p.getId() %>">Modifica</a> |
            <form action="<%= request.getContextPath() %>/EliminaProdottoServlet" method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%= p.getId() %>">
                <button type="submit" onclick="return confirm('Sei sicuro di voler eliminare questo prodotto?')">Elimina</button>
            </form>
        </td>
    </tr>
    <%
        }
    %>
</table>