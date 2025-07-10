<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Recupero Password - BeeNatural</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/recupera-password.css">
</head>
<body>
    <div class="centered">
        <img src="${pageContext.request.contextPath}/images/loghi/Logo.jpeg" alt="Logo BeeNatural">
        <div class="recover-form">
            <h2>Recupera la tua password</h2>
            <form method="post" action="${pageContext.request.contextPath}/recupera-password">
                <label for="email">Inserisci la tua email:</label>
                <input type="email" id="email" name="email" required>
                <button type="submit">Invia</button>
            </form>

            <div class="messaggio errore">
                <%= request.getAttribute("errore") != null ? request.getAttribute("errore") : "" %>
            </div>
            <div class="messaggio successo">
                <%= request.getAttribute("successo") != null ? request.getAttribute("successo") : "" %>
            </div>
        </div>
    </div>
</body>
</html>