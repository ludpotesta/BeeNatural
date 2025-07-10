<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="model.bean.Utente" %>
<jsp:include page="/views/include/barra-utente.jsp" />

<%
    Utente utente = (Utente) session.getAttribute("utente");
    if (utente == null) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        return;
    }

    String errore = (String) request.getAttribute("errore");
    String successo = (String) request.getAttribute("successo");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Modifica Profilo - BeeNatural</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modifica-profilo.css">
</head>
<body>

<div class="container-form">
    <h2 class="form-title">Modifica il tuo profilo</h2>

    <% if (errore != null) { %>
        <p class="msg-errore"><%= errore %></p>
    <% } else if (successo != null) { %>
        <p class="msg-successo"><%= successo %></p>
    <% } %>

    <form method="post" action="<%= request.getContextPath() %>/modifica-profilo" id="formProfilo">
        <label>Nome:</label>
        <input type="text" name="nome" value="<%= utente.getNome() %>" required>

        <label>Cognome:</label>
        <input type="text" name="cognome" value="<%= utente.getCognome() != null ? utente.getCognome() : "" %>">

        <label>Email:</label>
        <input type="email" name="email" value="<%= utente.getEmail() %>" required>

        <label>Indirizzo:</label>
        <input type="text" name="indirizzo" value="<%= utente.getIndirizzo() != null ? utente.getIndirizzo() : "" %>">

        <label>Telefono:</label>
        <input type="text" name="telefono" value="<%= utente.getTelefono() != null ? utente.getTelefono() : "" %>">

        <label>Nuova password:</label>
        <input type="password" name="nuovaPassword" id="nuovaPassword" pattern=".{8,}" title="Minimo 8 caratteri">
        <span class="errore" id="msgNuovaPassword"></span>

        <label>Conferma password:</label>
        <input type="password" name="confermaPassword" id="confermaPassword" pattern=".{8,}" title="Minimo 8 caratteri">
        <span class="errore" id="msgConfermaPassword"></span>

        <button type="submit">Aggiorna</button>
    </form>
</div>

<script>
    const nuovaPassword = document.getElementById("nuovaPassword");
    const confermaPassword = document.getElementById("confermaPassword");
    const msgNuova = document.getElementById("msgNuovaPassword");
    const msgConf = document.getElementById("msgConfermaPassword");

    function validaPassword() {
        const np = nuovaPassword.value;
        const cp = confermaPassword.value;

        if (np.length > 0 && np.length < 8) {
            msgNuova.textContent = "Minimo 8 caratteri";
            nuovaPassword.classList.remove("valid");
        } else {
            msgNuova.textContent = "";
            if (np.length >= 8) nuovaPassword.classList.add("valid");
        }

        if (cp.length > 0 && cp !== np) {
            msgConf.textContent = "Le password non coincidono";
            confermaPassword.classList.remove("valid");
        } else {
            msgConf.textContent = "";
            if (cp.length >= 8 && cp === np) confermaPassword.classList.add("valid");
        }
    }

    nuovaPassword.addEventListener("input", validaPassword);
    confermaPassword.addEventListener("input", validaPassword);
</script>

</body>
</html>