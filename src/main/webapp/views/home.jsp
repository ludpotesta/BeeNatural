<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="model.bean.Utente" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BeeNatural - Home</title>
</head>
<body>
    <h1>Benvenuto su BeeNatural!</h1>

    <!-- Mostra il messaggio se presente -->
    <%
        String messaggio = (String) request.getAttribute("messaggio");
        if (messaggio != null) {
    %>
        <p style="color: green;"><strong><%= messaggio %></strong></p>
    <%
        }
        Utente utente = (Utente) session.getAttribute("utente");
        if (utente != null) {
    %>
        <p>Ciao, <%= utente.getNome() %>!</p>
        <a href="<%= request.getContextPath() %>/catalogo">Vai al catalogo</a><br>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    <%
        } else {
    %>
        <p>Per accedere al catalogo, effettua il <a href="<%= request.getContextPath() %>/views/login.jsp">Login</a>.</p>
        <p>Non hai un account? <a href="<%= request.getContextPath() %>/views/register.jsp">Registrati</a></p>
    <%
        }
    %>
</body>
</html>