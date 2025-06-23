<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.JavaBeans.Cliente" %>
<%@ page session="true" %>

<%
    Cliente utente = (Cliente) session.getAttribute("utenteLoggato");
    if (utente == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Home - Benvenuto <%= utente.getNome() %></title>
    <link rel="stylesheet" href="css/stileRegistrazione.css">
</head>
<body>

<img src="img/logo.webp" alt="Logo" class="logo">

<div id="contenitoreForm">
    <h2>Benvenuto, <%= utente.getNome() %>!</h2>
    <p>Saldo disponibile: € <%= String.format("%.2f", utente.getSaldo()) %></p>

    <a href="VisualizzaArticoliServlet" class="bottone">Vai allo shop</a>
    <a href="modificaCredenziali.jsp" class="bottone">Modifica credenziali</a>
    <a href="LogoutServlet" class="bottone">Logout</a>
</div>

</body>
</html>
