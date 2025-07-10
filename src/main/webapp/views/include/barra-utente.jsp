<%@ page import="model.bean.Utente, model.bean.Carrello" %>

<%
    Utente utente = (Utente) session.getAttribute("utente");
    Carrello carrello = (Carrello) session.getAttribute("carrello");
    int numProdotti = (carrello != null) ? carrello.getNumeroProdottiTotale() : 0;
%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/barra-utente.css">

<header>
    <div class="nav-container">
        <div class="nav-left">
            <span class="greeting">
                Ciao, <%= utente != null ? utente.getNome() : "Ospite" %>
            </span>
            <a href="${pageContext.request.contextPath}/catalogo">Catalogo</a>
            <% if (utente != null) { %>
                <a href="${pageContext.request.contextPath}/profilo">Profilo</a>
                <a href="${pageContext.request.contextPath}/modifica-profilo">Modifica Profilo</a>
                <% if ("admin".equalsIgnoreCase(utente.getRuolo())) { %>
                    <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Admin</a>
                <% } %>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/views/login.jsp">Login</a>
                <a href="${pageContext.request.contextPath}/views/register.jsp">Registrati</a>
            <% } %>
        </div>

        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/views/carrello.jsp" class="cart-icon">
                <img src="https://cdn-icons-png.flaticon.com/512/263/263142.png" alt="Carrello">
                <% if (numProdotti > 0) { %>
                    <span class="cart-badge"><%= numProdotti %></span>
                <% } %>
            </a>
        </div>
    </div>
</header>