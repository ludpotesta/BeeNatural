<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="model.bean.Utente" %>

<%
    Utente utente = (Utente) session.getAttribute("utente");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"/>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function mostraCampiPagamento() {
            const metodo = document.getElementById("metodoPagamento").value;
            document.getElementById("carta").classList.add("hidden");
            document.getElementById("paypal").classList.add("hidden");

            if (metodo === "Carta di credito") {
                document.getElementById("carta").classList.remove("hidden");
            } else if (metodo === "PayPal") {
                document.getElementById("paypal").classList.remove("hidden");
            }
        }
    </script>
</head>
<body>

<jsp:include page="/views/include/barra-utente.jsp" />

<div class="container mt-4">
    <h2 class="section-title">Completa il tuo ordine</h2>

    <form method="post" action="${pageContext.request.contextPath}/checkout" class="checkout-form">
        <h4>📦 Indirizzo di spedizione</h4>
        <div class="form-group">
            <label>Indirizzo</label>
            <input type="text" name="indirizzoSped" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Città</label>
            <input type="text" name="cittaSped" class="form-control" required>
        </div>
        <div class="form-group">
            <label>CAP</label>
            <input type="text" name="capSped" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Stato</label>
            <input type="text" name="statoSped" class="form-control" required>
        </div>

        <h4>📑 Indirizzo di fatturazione</h4>
        <div class="form-group">
            <label>Indirizzo</label>
            <input type="text" name="indirizzoFatt" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Città</label>
            <input type="text" name="cittaFatt" class="form-control" required>
        </div>
        <div class="form-group">
            <label>CAP</label>
            <input type="text" name="capFatt" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Stato</label>
            <input type="text" name="statoFatt" class="form-control" required>
        </div>

        <h4>💳 Metodo di pagamento</h4>
        <div class="form-group">
            <label for="metodoPagamento">Seleziona metodo</label>
            <select name="metodoPagamento" id="metodoPagamento" class="form-control" onchange="mostraCampiPagamento()" required>
                <option value="">-- Seleziona --</option>
                <option value="Carta di credito">Carta di credito</option>
                <option value="PayPal">PayPal</option>
            </select>
        </div>

        <div id="carta" class="hidden">
            <div class="form-group">
                <label>Numero carta</label>
                <input type="text" name="numeroCarta" class="form-control" placeholder="0000 0000 0000 0000">
            </div>
            <div class="form-group">
                <label>Scadenza</label>
                <input type="month" name="scadenzaCarta" class="form-control">
            </div>
            <div class="form-group">
                <label>CVV</label>
                <input type="text" name="cvvCarta" maxlength="4" class="form-control">
            </div>
        </div>

        <div id="paypal" class="hidden">
            <div class="form-group">
                <label>Email PayPal</label>
                <input type="email" name="paypalEmail" class="form-control">
            </div>
        </div>

        <button type="submit" class="btn-conferma">Conferma ordine</button>
    </form>
</div>

</body>
</html>