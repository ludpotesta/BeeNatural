<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.bean.Utente" %>
<%
    Utente utente = (Utente) session.getAttribute("utente");
    if (utente == null || !"admin".equalsIgnoreCase(utente.getRuolo())) {
        response.sendRedirect(request.getContextPath() + "/views/error.jsp");
        return;
    }
%>
<jsp:include page="/views/include/barra-utente.jsp" />

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
                    </tr>
                </thead>
                <tbody>
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
                                                        <td>Prodotto ID: ${dettaglio.idProdotto}</td>
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

<jsp:include page="/views/include/footer.jsp" />