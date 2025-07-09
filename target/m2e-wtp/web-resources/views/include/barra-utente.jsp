<%@ page import="model.bean.Utente" %>

<%
    Utente utente = (Utente) session.getAttribute("utente");
%>

<div style="display: flex; justify-content: space-between; align-items: center; padding: 10px;">
    <div>
        <strong>Ciao, <%= utente != null ? utente.getNome() : "Ospite" %></strong>
        |
        <a href="<%= request.getContextPath() %>/catalogo">Catalogo</a> |
        <a href="<%= request.getContextPath() %>/profilo">Profilo</a>
        <% if (utente != null && "admin".equalsIgnoreCase(utente.getRuolo())) { %>
            | <a href="<%= request.getContextPath() %>/admin/dashboard.jsp">Dashboard Admin</a>
        <% } %>
        |
        <a href="<%= request.getContextPath() %>/modifica-profilo">Modifica Profilo</a> |
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
    <%
    model.bean.Carrello carrello = (model.bean.Carrello) session.getAttribute("carrello");
    int numProdotti = (carrello != null) ? carrello.getNumeroProdottiTotale() : 0;
%>

<div>
    <a href="<%= request.getContextPath() %>/views/carrello.jsp" style="position: relative; display: inline-block;">
        <img src="https://cdn-icons-png.flaticon.com/512/263/263142.png"
             alt="Carrello" width="24" height="24" style="vertical-align: middle;">
        <% if (numProdotti > 0) { %>
            <span style="position: absolute; top: -8px; right: -8px; background: red; color: white; font-size: 12px; border-radius: 50%; padding: 2px 6px;">
                <%= numProdotti %>
            </span>
        <% } %>
    </a>
</div>
</div>
<hr/>