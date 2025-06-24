<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.JavaBeans.Cliente" %>
<%@ page session="true" %>

<%
    Cliente utente=(Cliente) session.getAttribute("utenteLoggato");
    if(utente==null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <title>Area Utente -  Benvenuto <%=utente.getNome() %></title>
    <link rel="stylesheet" href="css/stileRegistrazione.css">
    <link rel="icon" href="img/logo.webp">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
<!--  jsp:include page="header.jsp"   -->    <!-- da fare successivamente -->
<h2>Ciao, <%=utente.getNome() %>!</h2>
<p>Saldo disponibile: € <%= String.format("%.2f", utente.getSaldo()) %></p>
<div class="contenitoreAreaUtente">
    <a href="ordini.jsp" class="boxAreaUtenteLink">
        <div class="boxAreaUtente">
            <img src="img/ordini.png" alt="Ordini" class="imgBoxAreaUtente" />
            <p>Ordini</p>
        </div>
    </a>
    <a href="metodipagamento.jsp" class="boxAreaUtenteLink">
        <div class="boxAreaUtente">
            <img src="img/credit-card.png" alt="Metodi di Pagamento" class="imgBoxAreaUtente" />
            <p>Metodi di Pagamento</p>
        </div>
    </a>
    <a href="indirizzi.jsp" class="boxAreaUtenteLink">
        <div class="boxAreaUtente">
            <img src="img/indrizzi.png" alt="Indirizzi" class="imgBoxAreaUtente" />
            <p>Indirizzi</p>
        </div>
    </a>
    <a href="impostazioni.jsp" class="boxAreaUtenteLink">
        <div class="boxAreaUtente">
            <img src="img/impostazioni.png" alt="Impostazioni" class="imgBoxAreaUtente" />
            <p>Impostazioni</p>
        </div>
    </a>
</div>
<%
    // Se l'utente è loggato mostra il bottone logout
    if (session.getAttribute("utenteLoggato") != null) {
%>
    <form action="LogoutServlet" method="get" class="bott" style="text-align:center; margin-top:30px;">
        <input type="submit" value="Logout" class="bott1" />
    </form>
<%
    } else {
%>
    <a href="login.jsp" style="display:block; text-align:center; margin-top:30px;">
        <div class="boxAreaUtente">
            <img src="img/login.png" class="imgBoxAreaUtente" alt="Login" />
        </div>
    </a>
<%
    }
%>
<jsp:include page="footerAreaUtente.jsp" />

</body>
</html>
