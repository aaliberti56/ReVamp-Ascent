<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.JavaBeans.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("../loginAdmin.jsp?errore=true");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Area Admin</title>
    <link rel="stylesheet" href="css/stileRegistrazione.css">
    <link rel="icon" type="image/x-icon" href="img/logo.webp">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<img src="img/logo.webp" alt="Logo" class="logo">

<div id="contenitoreForm">
    <h2 class="titoloLogin">Area Amministratore</h2>

    <p style="text-align:center; margin-bottom: 10px;">
        Benvenuto, <strong><%= admin.getNome() %> <%= admin.getCognome() %></strong><br>
        <small>Username: <%= admin.getUsername() %></small>
    </p>

    <hr style="margin: 20px 0; border: none; border-top: 1px solid #ccc;">

    <a href="FormAggiungiArticoloServlet" class="bottone">
        ➕ Aggiungi Articoli
    </a>

    <a href="LogoutServlet" class="bottone" style="background-color: #999;">
        ⛔ Logout
    </a>

    <a href="listaUtentiAdmin.jsp" class="bottone" style="background-color: #999;">
        Lista Utenti
    </a>


</div>

</body>
</html>
