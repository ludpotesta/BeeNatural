<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.util.*" %>
<%@ page import="model.bean.Ordine" %>
<%@ page import="model.bean.DettaglioOrdine" %>
<%@ page import="model.bean.Utente" %>
<%@ include file="include/barra-utente.jsp" %>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"/>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<%
    if (utente == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Ordine> ordini = new ArrayList<>();
    Object ordiniObj = request.getAttribute("ordiniObj");
    if (ordiniObj instanceof List<?>) {
        for (Object o : (List<?>) ordiniObj) {
            if (o instanceof Ordine) {
                ordini.add((Ordine) o);
            }
        }
    }
%>

<div class="container mt-4">
    <h2>Benvenuto nel tuo profilo</h2>

    <p><strong>Nome:</strong> <%= utente.getNome() %> <%= utente.getCognome() %></p>
    <p><strong>Email:</strong> <%= utente.getEmail() %></p>
    <p><strong>Indirizzo:</strong> <%= utente.getIndirizzo() != null ? utente.getIndirizzo() : "-" %></p>
    <p><strong>Telefono:</strong> <%= utente.getTelefono() != null ? utente.getTelefono() : "-" %></p>

    <h3 class="mt-4">Storico Ordini</h3>
    <% if (!ordini.isEmpty()) { %>
        <% for (Ordine o : ordini) { %>
            <div class="card mb-4">
                <div class="card-header">
                    <strong>Ordine #<%= o.getId() %></strong> — <%= o.getData() %>
                </div>
                <div class="card-body">
                    <p><strong>Totale:</strong> € <%= o.getTotalePagato() %></p>
                    <p><strong>Metodo di pagamento:</strong> <%= o.getMetodoPagamento() %></p>
                    <button class="btn btn-info btn-sm" data-toggle="modal" data-target="#dettagliOrdine<%= o.getId() %>">
                        Visualizza
                    </button>
                </div>
            </div>
        <% } %>

        <!-- MODALI -->
        <% for (Ordine o : ordini) { %>
            <div class="modal fade" id="dettagliOrdine<%= o.getId() %>" tabindex="-1" role="dialog">
              <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title">Dettagli Ordine #<%= o.getId() %></h5>
                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                  </div>
                  <div class="modal-body">
                    <!-- Info cliente -->
                    <p><strong>Nome:</strong> <%= utente.getNome() %> <%= utente.getCognome() %></p>
                    <p><strong>Email:</strong> <%= utente.getEmail() %></p>
                    <p><strong>Telefono:</strong> <%= utente.getTelefono() %></p>

                    <!-- Indirizzi -->
                    <p><strong>Indirizzo Spedizione:</strong> <%= o.getIndirizzoSped() %></p>
                    <p><strong>Indirizzo Fatturazione:</strong> <%= o.getIndirizzoFatturazione() %></p>

                    <!-- Prodotti -->
                    <h5>Prodotti:</h5>
                    <table class="table table-sm">
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
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                  </div>
                </div>
              </div>
            </div>
        <% } %>
    <% } else { %>
        <p>Nessun ordine disponibile.</p>
    <% } %>
</div>