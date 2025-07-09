<%@ page import="model.bean.Utente" %>
<%
    Utente utente = (Utente) session.getAttribute("utente");
    if (utente == null || !"admin".equalsIgnoreCase(utente.getRuolo())) {
        response.sendRedirect("../views/error.jsp");
        return;
    }
%>
<jsp:include page="/views/include/barra-utente.jsp" />
<h1>Benvenuto Admin <%= utente.getNome() %></h1>
<ul>
    <li><a href="${pageContext.request.contextPath}/admin/gestione-prodotti">Gestione Prodotti</a></li>
    <li><a href="${pageContext.request.contextPath}/admin/gestione-ordini">Gestione Ordini</a></li>
</ul>