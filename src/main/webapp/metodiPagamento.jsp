<%--
  Created by IntelliJ IDEA.
  User: aless
  Date: 26/06/2025
  Time: 18:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         import="model.*"
         import="java.util.*"
%>
<%@ page import="model.DAO.MetodiPagamentoDAO" %>
<html>
<head>
    <title>I Tuoi Metodi Di Pagamento</title>
    <link rel="stylesheet" href="css/stileRegistrazione.css">
    <link rel="icon" type="image/x-icon" href="img/logo.webp">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<!--   jsp:include page="header.jsp" -->
<%
    Cliente u = (Cliente) session.getAttribute("utenteLoggato");
    if (u == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    MetodiPagamentoDAO pagamentoDAO=new MetodiPagamentoDAO();
    List<MetodiPagamento> carte=pagamentoDAO.doRetrieveByUser(u.getNomeUtente());
    if (carte == null || carte.isEmpty()) {
%>
<p>Non hai ancora metodi di pagamento salvati.</p>
<%
} else {
%>
<h2>I Tuoi Metodi Di Pagamento</h2>
<div class="contcarte">
    <%
        for (MetodiPagamentoBean carta : carte) {
            GregorianCalendar dataScad = carta.getData_Scadenza();
            int mese = dataScad.get(GregorianCalendar.MONTH) + 1; // 0-based
            int anno = dataScad.get(GregorianCalendar.YEAR);
            String scadenzaFormattata = String.format("%02d/%d", mese, anno);
    %>
    <div class="singolopagamento">
        <div class="fotcarta">
            <img alt="creditcard" src="img/creditcard.png" class="iconaMenu">
        </div>
        <div class="datcarta">
            <%= carta.getNum_carta() %><br/>
            <%= carta.getIntestatario() %><br/>
            Scadenza: <%= scadenzaFormattata %><br/>
            CVV: ***<br/>
        </div>
    </div>
    <%
        }
    %>
</div>
<%
    }
%>
<div class="contnuovopag">
    <h3>Aggiungi un nuovo metodo di pagamento</h3>
    <form action="InserisciMetodoPagamento" method="POST" onsubmit="return cardnumber() && cvv() && datacreditcard()">
        <div class="contenitore">
            <div class="immagine1">
                <img src="img/logo.webp" class="immagine">
                <img src="img/chip.png" class="immagine">
            </div>
            <div class="daticarta">
                <label>Numero di carta</label><br>
                <input type="text" name="numerodicarta" id="numcarta" placeholder="1234 1234 1234 1234" class="dat" required><br>
                <label>Scadenza (MM/YY)</label><br>
                <input type="text" name="scadenza" placeholder="MM/YY" class="dat" required id="scadenzacarta"><br>
                <label>Intestatario</label><br>
                <input type="text" name="proprietario" placeholder="Intestatario" class="dat" required><br>
                <label>CVV</label><br>
                <input type="text" name="CVV" id="numcvv" placeholder="***" class="dat" required>
                <input type="hidden" name="nome_utente" value="<%= u.getNome_utente() %>">
                <input type="hidden" name="from" value="setting">
                <br>
                <input type="image" src="img/add.png" class="iconaMenu addBtn" alt="Aggiungi">
            </div>
        </div>
    </form>
</div>

<jsp:include page="footer.jsp" />

<script>
    // Puoi inserire qui le tue funzioni cardnumber(), cvv(), datacreditcard()
</script>

</body>
</html>


