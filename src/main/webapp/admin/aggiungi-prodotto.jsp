<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.bean.Utente" %>

<%
    Utente utente = (Utente) session.getAttribute("utente");
    if (utente == null || !"admin".equalsIgnoreCase(utente.getRuolo())) {
        response.sendRedirect("../views/error.jsp");
        return;
    }
%>

<jsp:include page="/views/include/barra-utente.jsp" />

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Aggiungi Nuovo Prodotto</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/aggiungi-prodotto.css">
</head>
<body>
<div class="container">
    <h1>Aggiungi Nuovo Prodotto</h1>

    <form action="${pageContext.request.contextPath}/aggiungi-prodotto" method="post" enctype="multipart/form-data">
        <label for="nome">Nome Prodotto:</label>
        <input type="text" id="nome" name="nome" required>

        <label for="descrizione">Descrizione:</label>
        <textarea id="descrizione" name="descrizione" rows="4"></textarea>

        <label for="prezzo">Prezzo (€):</label>
        <input type="number" id="prezzo" name="prezzo" step="0.01" min="0" required>

        <label for="categoria">Categoria:</label>
        <select id="categoria" name="categoria" required>
            <option value="">Seleziona categoria</option>
            <option value="Viso">Viso</option>
            <option value="Corpo">Corpo</option>
            <option value="Capelli">Capelli</option>
            <option value="Makeup">Makeup</option>
            <option value="Profumi">Profumi</option>
            <option value="Accessori">Accessori</option>
        </select>

        <label for="quantita">Quantità:</label>
        <input type="number" id="quantita" name="quantita" min="0" required>

        <label for="immagine">Immagine (JPG/PNG):</label>
        <input type="file" id="immagine" name="immagine" accept="image/*" required>

        <button type="submit">Aggiungi Prodotto</button>
        <a href="${pageContext.request.contextPath}/admin/gestione-prodotti" class="annulla-btn">Annulla</a>
    </form>
</div>
</body>
</html>