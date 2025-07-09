<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="model.bean.Utente" %>
<jsp:include page="/views/include/barra-utente.jsp" />

<%
    // Recupera l'utente solo se non esiste già
    Utente utente = (Utente) session.getAttribute("utente");
    if (utente == null) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        return;
    }

    String errore = (String) request.getAttribute("errore");
    String successo = (String) request.getAttribute("successo");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifica Profilo</title>
    <style>
        .errore {
            color: red;
            font-size: 0.9em;
            margin-left: 10px;
        }
        input:invalid {
            border-color: red;
        }
        input.valid {
            border-color: green;
        }
    </style>
</head>
<body>

<h2>Modifica il tuo profilo</h2>

<% if (errore != null) { %>
    <p style="color: red;"><%= errore %></p>
<% } else if (successo != null) { %>
    <p style="color: green;"><%= successo %></p>
<% } %>

<form method="post" action="<%= request.getContextPath() %>/modifica-profilo" id="formProfilo">
    <label>Nome:</label>
    <input type="text" name="nome" value="<%= utente.getNome() %>" required><br>

    <label>Cognome:</label>
    <input type="text" name="cognome" value="<%= utente.getCognome() != null ? utente.getCognome() : "" %>"><br>

    <label>Email:</label>
    <input type="email" name="email" value="<%= utente.getEmail() %>" required><br>

    <label>Indirizzo:</label>
    <input type="text" name="indirizzo" value="<%= utente.getIndirizzo() != null ? utente.getIndirizzo() : "" %>"><br>

    <label>Telefono:</label>
    <input type="text" name="telefono" value="<%= utente.getTelefono() != null ? utente.getTelefono() : "" %>"><br><br>

    <label>Nuova password:</label>
    <input type="password" name="nuovaPassword" id="nuovaPassword" pattern=".{8,}" title="Minimo 8 caratteri">
    <span class="errore" id="msgNuovaPassword"></span><br>

    <label>Conferma password:</label>
    <input type="password" name="confermaPassword" id="confermaPassword" pattern=".{8,}" title="Minimo 8 caratteri">
    <span class="errore" id="msgConfermaPassword"></span><br><br>

    <button type="submit">Aggiorna</button>
</form>

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