<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <title>Login - BeeNatural</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>
    <div class="centered">
        <img src="${pageContext.request.contextPath}/images/loghi/Logo.jpeg" alt="Logo BeeNatural">
        <div class="login-form">
            <h1>Accedi al tuo account</h1>
            <form action="${pageContext.request.contextPath}/login" method="post">
                <input type="text" name="email" placeholder="Email" required>
                <input type="password" name="password" placeholder="Password" required>
                <button type="submit" class="btn-accedi">Accedi</button>
            </form>
            <% String errore = (String) request.getAttribute("erroreLogin");
   			if (errore != null) { %>
   			 <div class="errore-login"><%= errore %></div>
			<% } %>
            <div class="link">
                <a href="${pageContext.request.contextPath}/views/recupera-password.jsp">Password dimenticata?</a><br>
                Non hai un account?
                <a href="${pageContext.request.contextPath}/views/register.jsp">Registrati</a><br>
                Oppure <a href="${pageContext.request.contextPath}/catalogo">continua come ospite</a>
            </div>
        </div>
    </div>
</body>
</html>