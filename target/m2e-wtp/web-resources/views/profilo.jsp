<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.*" %>
<%@ page import="model.bean.Ordine, model.bean.DettaglioOrdine, model.bean.Utente" %>
<%@ include file="include/barra-utente.jsp" %>

<%
    if (utente == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Ordine> ordini = new ArrayList<>();
    Object ordiniObj = request.getAttribute("ordiniObj");
    if (ordiniObj instanceof List<?>) {
        for (Object o : (List<?>) ordiniObj) {
            if (o instanceof Ordine) ordini.add((Ordine) o);
        }
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Profilo - BeeNatural</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profilo.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"/>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container mt-4">
    <h2 class="section-title">Il tuo profilo</h2>

    <div class="user-info">
        <p><strong>Nome:</strong> <%= utente.getNome() %> <%= utente.getCognome() %></p>
        <p><strong>Email:</strong> <%= utente.getEmail() %></p>
        <p><strong>Indirizzo:</strong> <%= utente.getIndirizzo() != null ? utente.getIndirizzo() : "-" %></p>
        <p><strong>Telefono:</strong> <%= utente.getTelefono() != null ? utente.getTelefono() : "-" %></p>
    </div>

    <h3 class="section-subtitle">Storico Ordini</h3>
    <% if (!ordini.isEmpty()) { %>
        <% for (Ordine o : ordini) { %>
            <div class="ordine-card">
                <div class="ordine-header">
                    <span><strong>Ordine #<%= o.getId() %></strong> — <%= o.getData() %></span>
                    <button class="btn btn-outline-dark btn-sm" data-toggle="modal" data-target="#dettagliOrdine<%= o.getId() %>">
                        Visualizza
                    </button>
                </div>
                <p><strong>Totale:</strong> € <%= o.getTotalePagato() %></p>
                <p><strong>Metodo di pagamento:</strong> <%= o.getMetodoPagamento() %></p>
            </div>
        <% } %>

        <!-- Modali Dettaglio Ordini -->
        <% for (Ordine o : ordini) { %>
        <div class="modal fade custom-modal" id="dettagliOrdine<%= o.getId() %>" tabindex="-1" role="dialog">
          <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">
              <div class="modal-header custom-modal-header">
                <h5 class="modal-title">Dettagli Ordine #<%= o.getId() %></h5>
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
              </div>
              <div class="modal-body custom-modal-body">
                <p><strong>Nome:</strong> <%= utente.getNome() %> <%= utente.getCognome() %></p>
                <p><strong>Email:</strong> <%= utente.getEmail() %></p>
                <p><strong>Telefono:</strong> <%= utente.getTelefono() %></p>
                <p><strong>Indirizzo Spedizione:</strong> <%= o.getIndirizzoSped() %></p>
                <p><strong>Indirizzo Fatturazione:</strong> <%= o.getIndirizzoFatturazione() %></p>

                <h5 class="mt-3">Prodotti:</h5>
                <div class="table-responsive">
                    <table class="table table-sm custom-table">
                      <thead>
                        <tr>
                          <th>Prodotto</th>
                          <th>Quantità</th>
                          <th>Prezzo Unitario</th>
                          <th>Totale</th>
                        </tr>
                      </thead>
                      <tbody>
                        <% for (DettaglioOrdine d : o.getDettagli()) { %>
                          <tr>
                            <td>
                              <strong><%= d.getNomeProdotto() %></strong><br/>
                              <small><%= d.getDescrizioneProdotto() %></small><br/>
                              <img src="<%= request.getContextPath() %>/images/prodotti/<%= d.getImmagineProdotto() %>"
                                   width="60" height="60"/>
                            </td>
                            <td><%= d.getQuantita() %></td>
                            <td>€ <%= d.getPrezzoPagato() %></td>
                            <td>€ <%= d.getQuantita() * d.getPrezzoPagato() %></td>
                          </tr>
                        <% } %>
                      </tbody>
                    </table>
                </div>
              </div>
            </div>
          </div>
        </div>
        <% } %>
    <% } else { %>
        <p>Nessun ordine effettuato.</p>
    <% } %>
</div>

</body>
</html>