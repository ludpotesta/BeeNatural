<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%
    boolean recupero = request.getParameter("recupero") != null;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifica la tua password</title>
</head>
<body>
    <h2>Modifica la tua password</h2>

    <% if (request.getAttribute("errore") != null) { %>
        <p style="color: red;"><%= request.getAttribute("errore") %></p>
    <% } else if (request.getAttribute("successo") != null) { %>
        <p style="color: green;"><%= request.getAttribute("successo") %></p>
    <% } %>

    <form method="post" action="${pageContext.request.contextPath}/modifica-password<%= recupero ? "?recupero=true" : "" %>">
        <% if (recupero) { %>
            <label for="vecchiaPassword">Password temporanea:</label>
            <input type="password" id="vecchiaPassword" name="vecchiaPassword" required><br><br>
        <% } else { %>
            <label for="vecchiaPassword">Vecchia Password:</label>
            <input type="password" id="vecchiaPassword" name="vecchiaPassword" required><br><br>
        <% } %>

        <label for="nuovaPassword">Nuova Password:</label>
        <input type="password" id="nuovaPassword" name="nuovaPassword" required><br><br>

        <label for="confermaPassword">Conferma Password:</label>
        <input type="password" id="confermaPassword" name="confermaPassword" required><br><br>

        <span id="msgErrore" style="color:red;"></span><br>

        <button type="submit">Aggiorna Password</button>
    </form>

    <script>
    document.querySelector("form").addEventListener("submit", function (e) {
        const nuova = document.getElementById("nuovaPassword").value;
        const conferma = document.getElementById("confermaPassword").value;
        const errore = document.getElementById("msgErrore");

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