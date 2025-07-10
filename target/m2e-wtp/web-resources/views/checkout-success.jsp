<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.bean.Utente" %>

<%
    Utente utente = (Utente) session.getAttribute("utente");
    int idOrdine = (int) request.getAttribute("idOrdine");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Ordine completato</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout-success.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"/>
</head>
<body>

<jsp:include page="/views/include/barra-utente.jsp" />

<div class="container mt-5">
    <div class="success-box text-center">
        <h2 class="mb-4">🎉 Grazie per il tuo ordine, <%= utente.getNome() %>!</h2>
        <p class="lead">Il tuo ordine è stato registrato con successo.</p>
        <p><strong>Numero ordine:</strong> #<%= idOrdine %></p>

        <a href="<%= request.getContextPath() %>/profilo" class="btn btn-primary mt-4">Vai al tuo profilo</a>
    </div>
</div>

</body>
</html>