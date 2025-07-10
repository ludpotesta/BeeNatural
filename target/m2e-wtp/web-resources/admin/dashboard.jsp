<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.bean.Utente" %>

<%
    Utente utente = (Utente) session.getAttribute("utente");
    if (utente == null || !"admin".equalsIgnoreCase(utente.getRuolo())) {
        response.sendRedirect("../views/error.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<jsp:include page="/views/include/barra-utente.jsp" />

<div class="dashboard-container">
    <h1 class="dashboard-title">Benvenuto, <%= utente.getNome() %></h1>

    <div class="dashboard-links">
        <div class="dashboard-card">
            <h2><a href="${pageContext.request.contextPath}/admin/gestione-prodotti">Gestione Prodotti</a></h2>
            <p>Aggiungi, modifica o elimina i prodotti dal catalogo.</p>
        </div>

        <div class="dashboard-card">
            <h2><a href="${pageContext.request.contextPath}/admin/gestione-ordini">Gestione Ordini</a></h2>
            <p>Visualizza e gestisci gli ordini effettuati dagli utenti.</p>
        </div>
    </div>
</div>
</body>
</html>