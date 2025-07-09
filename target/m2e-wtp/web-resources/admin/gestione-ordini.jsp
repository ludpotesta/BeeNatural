<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="model.bean.Utente" %>
<%
    Utente utente = (Utente) session.getAttribute("utente");
    if (utente == null || !"admin".equalsIgnoreCase(utente.getRuolo())) {
        response.sendRedirect(request.getContextPath() + "/views/error.jsp");
        return;
    }
%>
<jsp:include page="/views/include/barra-utente.jsp" />

<!-- IMPORT NECESSARI per Bootstrap -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"/>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<div class="container mt-4">
    <h1>Gestione Ordini</h1>

    <div class="card mb-4">
        <div class="card-header">
            <h4>Storico Ordini</h4>
        </div>
        <div class="card-body">
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID Ordine</th>
                        <th>Data</th>
                        <th>Utente</th>
                        <th>Totale</th>
                        <th>Metodo Pagamento</th>
                        <th>Dettagli</th>
                        <th>Elimina</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty ordini}">
                        <tr>
                            <td colspan="7" class="text-center">Nessun ordine disponibile.</td>
                        </tr>
                    </c:if>

                    <c:forEach items="${ordini}" var="ordine">
                        <tr>
                            <td>${ordine.id}</td>
                            <td>${ordine.data}</td>
                            <td>ID: ${ordine.idUtente}</td>
                            <td>€ ${ordine.totalePagato}</td>
                            <td>${ordine.metodoPagamento}</td>
                            <td>
                                <button class="btn btn-info btn-sm" data-toggle="modal"
                                        data-target="#dettagliOrdine${ordine.id}">
                                    Visualizza
                                </button>
                            </td>
                            <td>
                                <form method="post" action="${pageContext.request.contextPath}/admin/elimina-ordine"
                                      onsubmit="return confirm('Confermi l\'eliminazione dell\'ordine #${ordine.id}?');">
                                    <input type="hidden" name="idOrdine" value="${ordine.id}" />
                                    <button type="submit" class="btn btn-danger btn-sm">Elimina</button>
                                </form>
                            </td>
                        </tr>

                        <!-- Modale Dettagli Ordine -->
                        <div class="modal fade" id="dettagliOrdine${ordine.id}" tabindex="-1" role="dialog">
                            <div class="modal-dialog modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Dettagli Ordine #${ordine.id}</h5>
                                        <button type="button" class="close" data-dismiss="modal">
                                            <span>&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">

                                        <!-- Info Cliente -->
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <h6>Dati Cliente:</h6>
                                                <p>
                                                    ${ordine.utente.nome} ${ordine.utente.cognome}<br/>
                                                    Email: ${ordine.utente.email}<br/>
                                                    Telefono: ${ordine.utente.telefono}
                                                </p>
                                            </div>
                                        </div>

                                        <!-- Indirizzi -->
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <h6>Indirizzo Spedizione:</h6>
                                                <p>${ordine.indirizzoSped}</p>
                                            </div>
                                            <div class="col-md-6">
                                                <h6>Indirizzo Fatturazione:</h6>
                                                <p>${ordine.indirizzoFatturazione}</p>
                                            </div>
                                        </div>

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
                                                <c:forEach items="${ordine.dettagli}" var="dettaglio">
                                                    <tr>
                                                        <td>
                                                            <strong>${dettaglio.nomeProdotto}</strong><br/>
                                                            <small>${dettaglio.descrizioneProdotto}</small><br/>
                                                            <img src="${pageContext.request.contextPath}/images/prodotti/${dettaglio.immagineProdotto}"
                                                                 width="60" height="60"/>
                                                        </td>
                                                        <td>${dettaglio.quantita}</td>
                                                        <td>€ ${dettaglio.prezzoPagato}</td>
                                                        <td>€ ${dettaglio.quantita * dettaglio.prezzoPagato}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>