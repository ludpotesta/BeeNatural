<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Catalogo - BeeNatural</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/catalogo.css">
</head>
<body>
    <jsp:include page="/views/include/barra-utente.jsp" />

    <h1>Catalogo Prodotti</h1>

    <c:choose>
        <c:when test="${empty prodotti}">
            <p>Nessun prodotto disponibile al momento</p>
        </c:when>
        <c:otherwise>
            <div class="product-grid">
                <c:forEach var="prodotto" items="${prodotti}">
                    <div class="product-card">
                        <img src="${pageContext.request.contextPath}/images/prodotti/${prodotto.immagine}"
                             alt="${prodotto.nome}">
                        <h3>${prodotto.nome}</h3>
                        <p>${prodotto.descrizione}</p>
                        <p class="price">
                            <fmt:formatNumber value="${prodotto.prezzoAttuale}"
                                              type="currency"
                                              currencyCode="EUR"/>
                        </p>
                        <form method="post" action="${pageContext.request.contextPath}/aggiungi-carrello">
                            <input type="hidden" name="id" value="${prodotto.id}">
                            <label for="quantita">Quantità:</label>
                            <input type="number" name="quantita" value="1" min="1" required>
                            <button type="submit">Aggiungi al carrello</button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</body>
</html>