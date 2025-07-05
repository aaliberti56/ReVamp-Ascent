<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.JavaBeans.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("../loginAdmin.jsp?errore=true");
        return;
    }
%>

<%@ include file="headerAdmin.jsp" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Area Admin - Benvenuto <%= admin.getNome() %></title>
    <link rel="icon" href="img/logo.webp">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/stileRegistrazione.css">
</head>
<body>

<div class="user-dashboard">
    <div class="user-header">
        <h2>Benvenuto, <%= admin.getNome() %> <%= admin.getCognome() %>!</h2>
        <h4>Area riservata amministratore</h4>
    </div>

    <div class="menu-grid">
        <a href="FormAggiungiArticoloServlet" class="menu-card">
            <img src="img/ad1.jpeg" alt="Aggiungi Articolo" class="menu-icon">
            <p>Aggiungi Articolo</p>
        </a>
        <a href="listaArticoli.jsp" class="menu-card">
            <img src="img/ad1.jpeg" alt="Modifica Articolo" class="menu-icon">
            <p>Modifica Articolo</p>
        </a>
        <a href="ordini.jsp" class="menu-card">
            <img src="img/ad1.jpeg" alt="Visualizza Ordini" class="menu-icon">
            <p>Visualizza Lista Ordini</p>
        </a>
        <a href="listaUtentiAdmin.jsp" class="menu-card">
            <img src="img/ad1.jpeg" alt="Visualizza utenti" class="menu-icon">
            <p>Visualizza Lista Utenti</p>
        </a>
    </div>

    <form action="AdminLogoutServlet" method="get" style="text-align:center; margin-top:30px;">
        <input type="submit" value="Logout" class="bott1">
    </form>
</div>

</body>
</html>
