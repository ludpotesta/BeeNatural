<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.bean.Utente" %>
<%
    Utente utente = (Utente) session.getAttribute("utente");
    String indirizzo = (utente != null && utente.getIndirizzo() != null) ? utente.getIndirizzo() : "";
%>

<html>
<head>
    <title>Checkout</title>
</head>
<body>
    <h2>Checkout</h2>
    <form action="<%= request.getContextPath() %>/CheckoutServlet" method="post">
        <label for="indirizzoSped">Indirizzo di Spedizione:</label><br>
        <input type="text" id="indirizzoSped" name="indirizzoSped" value="<%= indirizzo %>" required><br><br>

        <label for="indirizzoFatt">Indirizzo di Fatturazione:</label><br>
        <input type="text" id="indirizzoFatt" name="indirizzoFatt" value="<%= indirizzo %>" required>

        <label for="metodoPagamento">Metodo di pagamento:</label><br>
        <select id="metodoPagamento" name="metodoPagamento" required>
            <option value="Carta">Carta di credito</option>
            <option value="PayPal">PayPal</option>
            <option value="Contrassegno">Contrassegno</option>
        </select><br><br>

        <input type="submit" value="Conferma ordine">
    </form>
</body>
</html>