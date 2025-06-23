<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Admin</title>
    <link rel="stylesheet" href="css/stileRegistrazione.css">
    <link rel="icon" type="image/x-icon" href="img/logo.webp">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<%
    String errore = (String) request.getAttribute("erroreLogin");
    if (errore != null) {
%>
<div class="containerMessaggio">
    <div id="messaggioConferma">
        <img src="img/error.png" class="erroreMessaggio">
        <input type="image" src="img/close.png" class="chiudiMessaggio" onclick="nascondiMessaggio()">
        <span><%= errore %></span>
    </div>
</div>
<%
    }
%>

<img src="img/logo.webp" class="logo">

<div id="contenitoreForm">
    <h2 class="titoloLogin">Area Riservata</h2>
    <form action="AdminLoginServlet" method="post" id="formLogin">
        <input type="text" name="username" placeholder="Username" class="dati" id="username" required><br><br>
        <input type="password" name="password" placeholder="Password" class="dati" id="password" required><br><br>
        <span id="errorLogin" class="formError" style="display:none; color:red;">Inserisci correttamente le credenziali</span><br>
        <input type="submit" value="Login" class="bottone">
    </form>
</div>

<script src="js/script.js"></script>

</body>
</html>
