<%@ page import="model.bean.Utente" %>
<%
    Utente utente = (Utente) session.getAttribute("utente");
    if (utente == null || !"admin".equalsIgnoreCase(utente.getRuolo())) {
        response.sendRedirect("../views/error.jsp");
        return;
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/views/include/barra-utente.jsp" />

<h1>Aggiungi Nuovo Prodotto</h1>

<form action="${pageContext.request.contextPath}/aggiungi-prodotto" method="post" enctype="multipart/form-data">
    <div style="margin-bottom: 15px;">
        <label for="nome">Nome Prodotto:</label>
        <input type="text" id="nome" name="nome" required style="width: 300px; padding: 8px;">
    </div>
    
    <div style="margin-bottom: 15px;">
        <label for="descrizione">Descrizione:</label>
        <textarea id="descrizione" name="descrizione" rows="4" style="width: 300px; padding: 8px;"></textarea>
    </div>
    
    <div style="margin-bottom: 15px;">
        <label for="prezzo">Prezzo (€):</label>
        <input type="number" id="prezzo" name="prezzo" step="0.01" min="0" required style="width: 100px; padding: 8px;">
    </div>
    
    <div style="margin-bottom: 15px;">
        <label for="categoria">Categoria:</label>
        <select id="categoria" name="categoria" required style="padding: 8px;">
            <option value="">Seleziona categoria</option>
            <option value="Viso">Viso</option>
            <option value="Corpo">Corpo</option>
            <option value="Capelli">Capelli</option>
            <option value="Makeup">Makeup</option>
            <option value="Profumi">Profumi</option>
            <option value="Accessori">Accessori</option>
        </select>
    </div>
    
    <div style="margin-bottom: 15px;">
        <label for="quantita">Quantità:</label>
        <input type="number" id="quantita" name="quantita" min="0" required style="width: 80px; padding: 8px;">
    </div>
    
    <div style="margin-bottom: 15px;">
        <label for="immagine">Immagine (JPG/PNG):</label>
        <input type="file" id="immagine" name="immagine" accept="image/*" required>
    </div>
    
    <div>
        <button type="submit" style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer;">Aggiungi Prodotto</button>
        <a href="${pageContext.request.contextPath}/admin/gestione-prodotti" style="padding: 10px 20px; background-color: #f44336; color: white; text-decoration: none; margin-left: 10px;">Annulla</a>
    </div>
</form>