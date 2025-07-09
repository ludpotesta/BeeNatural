<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="model.bean.Utente" %>

<%
    Utente utente = (Utente) session.getAttribute("utente");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        form { max-width: 600px; margin: auto; }
        label { display: block; margin-top: 10px; font-weight: bold; }
        input, select { width: 100%; padding: 8px; margin-top: 5px; }
        .btn {
            margin-top: 20px;
            padding: 10px;
            background-color: #4CAF50;
            border: none;
            color: white;
            cursor: pointer;
        }
        .hidden { display: none; }
    </style>
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

<h2>Completa il tuo ordine</h2>

<form method="post" action="<%= request.getContextPath() %>/checkout">

    <h3>📦 Indirizzo di spedizione</h3>
    <label>Indirizzo</label>
    <input type="text" name="indirizzoSped" required>

    <label>Città</label>
    <input type="text" name="cittaSped" required>

    <label>CAP</label>
    <input type="text" name="capSped" required>

    <label>Stato</label>
    <input type="text" name="statoSped" required>

    <h3>📑 Indirizzo di fatturazione</h3>
    <label>Indirizzo</label>
    <input type="text" name="indirizzoFatt" required>

    <label>Città</label>
    <input type="text" name="cittaFatt" required>

    <label>CAP</label>
    <input type="text" name="capFatt" required>

    <label>Stato</label>
    <input type="text" name="statoFatt" required>

    <h3>💳 Metodo di pagamento</h3>
    <label for="metodoPagamento">Seleziona metodo</label>
    <select name="metodoPagamento" id="metodoPagamento" onchange="mostraCampiPagamento()" required>
        <option value="">-- Seleziona --</option>
        <option value="Carta di credito">Carta di credito</option>
        <option value="PayPal">PayPal</option>
    </select>

    <div id="carta" class="hidden">
        <label>Numero carta</label>
        <input type="text" name="numeroCarta" placeholder="0000 0000 0000 0000">
        <label>Scadenza</label>
        <input type="month" name="scadenzaCarta">
        <label>CVV</label>
        <input type="text" name="cvvCarta" maxlength="4">
    </div>

    <div id="paypal" class="hidden">
        <label>Email PayPal</label>
        <input type="email" name="paypalEmail">
    </div>

    <button type="submit" class="btn">Conferma ordine</button>
</form>

</body>
</html>