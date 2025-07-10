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
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione Ordini</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/gestione-ordini.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"/>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<jsp:include page="/views/include/barra-utente.jsp" />

<div class="container mt-4">
    <h2 class="section-title">Gestione Ordini</h2>

    <c:choose>
        <c:when test="${empty ordini}">
            <p class="text-center">Nessun ordine disponibile.</p>
        </c:when>
        <c:otherwise>
            <c:forEach items="${ordini}" var="ordine">
                <div class="ordine-card">
                    <div class="ordine-header">
                        <span><strong>Ordine #${ordine.id}</strong> — ${ordine.data}</span>
                        <div>
                            <button class="btn btn-outline-brown btn-sm" data-toggle="modal" data-target="#modal${ordine.id}">
                                Dettagli
                            </button>
                            <form method="post" action="${pageContext.request.contextPath}/admin/elimina-ordine"
                                  class="d-inline"
                                  onsubmit="return confirm('Confermi l\'eliminazione dell\'ordine #${ordine.id}?');">
                                <input type="hidden" name="idOrdine" value="${ordine.id}">
                                <button type="submit" class="btn btn-outline-red btn-sm">Elimina</button>
                            </form>
                        </div>
                    </div>
                    <p><strong>Utente:</strong> ID ${ordine.idUtente}</p>
                    <p><strong>Totale:</strong> € ${ordine.totalePagato}</p>
                    <p><strong>Metodo di pagamento:</strong> ${ordine.metodoPagamento}</p>
                </div>

                <!-- MODALE DETTAGLIO -->
                <div class="modal fade custom-modal" id="modal${ordine.id}" tabindex="-1" role="dialog">
                    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header custom-modal-header">
                                <h5 class="modal-title">Dettagli Ordine #${ordine.id}</h5>
                                <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                            </div>
                            <div class="modal-body custom-modal-body">
                                <p><strong>Nome:</strong> ${ordine.utente.nome} ${ordine.utente.cognome}</p>
                                <p><strong>Email:</strong> ${ordine.utente.email}</p>
                                <p><strong>Telefono:</strong> ${ordine.utente.telefono}</p>
                                <p><strong>Indirizzo Spedizione:</strong> ${ordine.indirizzoSped}</p>
                                <p><strong>Indirizzo Fatturazione:</strong> ${ordine.indirizzoFatturazione}</p>

                                <h5 class="mt-3">Prodotti:</h5>
                                <div class="table-responsive">
                                    <table class="table table-sm custom-table">
                                        <thead>
                                        <tr>
                                            <th>Prodotto</th>
                                            <th>Quantità</th>
                                            <th>Prezzo</th>
                                            <th>Totale</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${ordine.dettagli}" var="d">
                                            <tr>
                                                <td>
                                                    <strong>${d.nomeProdotto}</strong><br/>
                                                    <small>${d.descrizioneProdotto}</small><br/>
                                                    <img src="${pageContext.request.contextPath}/images/prodotti/${d.immagineProdotto}"
                                                         width="60" height="60"/>
                                                </td>
                                                <td>${d.quantita}</td>
                                                <td>€ ${d.prezzoPagato}</td>
                                                <td>€ ${d.quantita * d.prezzoPagato}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>