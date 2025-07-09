<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.*" %>
<%@ page import="model.bean.Ordine" %>
<%@ page import="model.bean.Utente" %>
<%@ include file="include/barra-utente.jsp" %>

<%
    if (utente == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Ordine> ordini = new ArrayList<>();
    Object ordiniObj = request.getAttribute("ordiniObj");
    if (ordiniObj instanceof List<?>) {
        for (Object o : (List<?>) ordiniObj) {
            if (o instanceof Ordine) {
                ordini.add((Ordine) o);
            }
        }
    }
%>

<h2>Benvenuto nel tuo profilo</h2>

<p><strong>Nome:</strong> <%= utente.getNome() %> <%= utente.getCognome() %></p>
<p><strong>Email:</strong> <%= utente.getEmail() %></p>
<p><strong>Indirizzo:</strong> <%= utente.getIndirizzo() != null ? utente.getIndirizzo() : "-" %></p>
<p><strong>Telefono:</strong> <%= utente.getTelefono() != null ? utente.getTelefono() : "-" %></p>

<h3>Storico Ordini</h3>
<% if (!ordini.isEmpty()) { %>
    <ul>
        <% for (Ordine o : ordini) { %>
            <li>Ordine #<%= o.getId() %> - <%= o.getData() %></li>
        <% } %>
    </ul>
<% } else { %>
    <p>Nessun ordine disponibile.</p>
<% } %>