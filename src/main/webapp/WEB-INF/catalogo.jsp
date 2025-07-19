<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="it">
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
        <p style="text-align:center;">Nessun prodotto disponibile al momento</p>
    </c:when>
    <c:otherwise>
        <div class="product-grid">
            <c:forEach var="prodotto" items="${prodotti}">
                <div class="product-card"
                     data-id="${prodotto.id}"
                     data-nome="${prodotto.nome}"
                     data-descrizione="${prodotto.descrizione}"
                     data-prezzo="<fmt:formatNumber value='${prodotto.prezzoAttuale}' type='currency' currencyCode='EUR'/>"
                     data-img="${pageContext.request.contextPath}/images/prodotti/${prodotto.immagine}"
                     data-quantita="${prodotto.quantità}">
                    <img src="${pageContext.request.contextPath}/images/prodotti/${prodotto.immagine}" alt="${prodotto.nome}">
                    <div class="product-info">
                        <h3>${prodotto.nome}</h3>
                        <p class="price">
                            <fmt:formatNumber value="${prodotto.prezzoAttuale}" type="currency" currencyCode="EUR"/>
                        </p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<!-- ✅ MODAL -->
<div class="modal-overlay" id="modal-overlay">
    <div class="modal" id="modal">
        <span class="modal-close" onclick="closeModal()">×</span>
        <img id="modal-img" src="" alt="" style="width:100%; max-height:200px; object-fit:contain;">
        <h3 id="modal-title"></h3>
        <p id="modal-desc"></p>
        <p class="price" id="modal-price"></p>
        <form method="post" action="${pageContext.request.contextPath}/aggiungi-carrello">
            <input type="hidden" name="id" id="modal-product-id">
            <label for="quantita">Quantità:</label>
            <input type="number" name="quantita" id="modal-quantita" value="1" min="1" required>
            <button type="submit">Aggiungi al carrello</button>
        </form>
    </div>
</div>

<script>
    const cards = document.querySelectorAll('.product-card');
    const modalOverlay = document.getElementById('modal-overlay');
    const modalTitle = document.getElementById('modal-title');
    const modalDesc = document.getElementById('modal-desc');
    const modalPrice = document.getElementById('modal-price');
    const modalImg = document.getElementById('modal-img');
    const modalProductId = document.getElementById('modal-product-id');
    const modalQuantita = document.getElementById('modal-quantita');

    cards.forEach(card => {
        card.addEventListener('click', () => {
            modalTitle.textContent = card.dataset.nome;
            modalDesc.textContent = card.dataset.descrizione;
            modalPrice.textContent = card.dataset.prezzo;
            modalImg.src = card.dataset.img;
            modalProductId.value = card.dataset.id;
            modalQuantita.max = card.dataset.quantita;
            modalQuantita.value = "1";
            modalOverlay.style.display = 'flex';
        });
    });

    function closeModal() {
        modalOverlay.style.display = 'none';
    }

    modalOverlay.addEventListener('click', function(e) {
        if (e.target === modalOverlay) closeModal();
    });
</script>
</body>
</html>