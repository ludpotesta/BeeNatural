<%@ page isErrorPage="true" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Errore - BeeNatural</title>
</head>
<body>
    <h2>Si è verificato un errore</h2>
    <p><strong>Messaggio:</strong> <%= exception != null ? exception.getMessage() : "Errore sconosciuto" %></p>
    <a href="<%= request.getContextPath() %>/views/home.jsp">Torna alla home</a>
</body>
</html>