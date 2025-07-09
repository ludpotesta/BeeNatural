<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recupero Password</title>
</head>
<body>
    <h2>Recupera la tua password</h2>

    <form method="post" action="${pageContext.request.contextPath}/recupera-password">
        <label for="email">Inserisci la tua email:</label>
        <input type="email" id="email" name="email" required>
        <button type="submit">Invia</button>
    </form>

    <div style="color: red;">
        <%= request.getAttribute("errore") != null ? request.getAttribute("errore") : "" %>
    </div>
    <div style="color: green;">
        <%= request.getAttribute("successo") != null ? request.getAttribute("successo") : "" %>
    </div>
</body>
</html>