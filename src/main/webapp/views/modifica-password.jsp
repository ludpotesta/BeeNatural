<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%
    boolean recupero = request.getParameter("recupero") != null;
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Modifica la tua password - BeeNatural</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modifica-password.css">
</head>
<body>
    <div class="centered">
        <img src="${pageContext.request.contextPath}/images/loghi/Logo.jpeg" alt="Logo BeeNatural">
        <div class="password-form">
            <h2>Modifica la tua password</h2>

            <% if (request.getAttribute("errore") != null) { %>
                <div class="messaggio errore"><%= request.getAttribute("errore") %></div>
            <% } else if (request.getAttribute("successo") != null) { %>
                <div class="messaggio successo"><%= request.getAttribute("successo") %></div>
            <% } %>

            <form method="post" action="${pageContext.request.contextPath}/modifica-password<%= recupero ? "?recupero=true" : "" %>">
                <label for="vecchiaPassword"><%= recupero ? "Password temporanea:" : "Vecchia Password:" %></label>
                <input type="password" id="vecchiaPassword" name="vecchiaPassword" required>

                <label for="nuovaPassword">Nuova Password:</label>
                <input type="password" id="nuovaPassword" name="nuovaPassword" required>

                <label for="confermaPassword">Conferma Password:</label>
                <input type="password" id="confermaPassword" name="confermaPassword" required>

                <span id="msgErrore" class="messaggio errore"></span>

                <button type="submit">Aggiorna Password</button>
            </form>
        </div>
    </div>

    <script>
        document.querySelector("form").addEventListener("submit", function (e) {
            const nuova = document.getElementById("nuovaPassword").value;
            const conferma = document.getElementById("confermaPassword").value;
            const errore = document.getElementById("msgErrore");

            errore.textContent = "";

            if (nuova.length < 8) {
                e.preventDefault();
                errore.textContent = "La nuova password deve essere di almeno 8 caratteri.";
            } else if (nuova !== conferma) {
                e.preventDefault();
                errore.textContent = "Le password non coincidono.";
            }
        });
    </script>
</body>
</html>