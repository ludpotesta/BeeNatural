<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="model.bean.Carrello" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - BeeNatural</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>

<h2>Accedi al tuo account</h2>

<%
    HttpSession sessione = request.getSession(false);
    if (sessione != null) {
        Carrello carrello = (Carrello) sessione.getAttribute("carrello");
        if (carrello != null && !carrello.getProdotti().isEmpty()) {
%>
    <div>
        <p><strong>Hai prodotti nel carrello!</strong> Accedi per salvarli nel tuo account e completare l'acquisto.</p>
    </div>
<%
        }
    }

    String errore = (String) request.getAttribute("errore");
    String successo = (String) request.getAttribute("successo");

    if (errore != null && !errore.isEmpty()) {
%>
    <div style="color: red;"><%= errore %></div>
<%
    }

    if (successo != null && !successo.isEmpty()) {
%>
    <div style="color: green;"><%= successo %></div>
<%
    }
%>

<form method="post" action="${pageContext.request.contextPath}/login">
    <label for="email">Email:</label>
    <input type="email" name="email" required><br><br>

    <label for="password">Password:</label>
    <input type="password" name="password" required><br><br>

    <button type="submit">Accedi</button>
</form>

<p><a href="${pageContext.request.contextPath}/views/recupera-password.jsp">Password dimenticata?</a></p>
<p>Non hai un account? <a href="${pageContext.request.contextPath}/views/register.jsp">Registrati</a></p>
<p>Oppure <a href="${pageContext.request.contextPath}/catalogo?guest=true">continua come ospite</a></p>

</body>
</html>