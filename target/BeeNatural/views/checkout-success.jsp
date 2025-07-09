<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.bean.Utente" %>

<%
    Utente utente = (Utente) session.getAttribute("utente");
    int idOrdine = (int) request.getAttribute("idOrdine");
%>

<html>
<head>
    <title>Ordine completato</title>
</head>
<body>
    <h2>Grazie per il tuo ordine, <%= utente.getNome() %>!</h2>
    <p>Il tuo ordine è stato registrato con successo.</p>
    <p><strong>Numero ordine:</strong> <%= idOrdine %></p>

    <a href="<%= request.getContextPath() %>/profilo">Vai al tuo profilo</a>
</body>
</html>