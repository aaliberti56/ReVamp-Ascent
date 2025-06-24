<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.JavaBeans.Cliente" %>
<%
    Cliente u = (Cliente) session.getAttribute("utenteLoggato");
    if (u == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Modifica Credenziali</title>
    <link rel="stylesheet" href="css/stileRegistrazione.css">  <!-- percorso corretto CSS -->
    <link rel="icon" type="image/x-icon" href="img/logo.webp">
</head>
<body>

<img src="img/logo.webp" class="logo">

<div id="contenitoreForm">
    <h2 class="titoloLogin">Modifica Credenziali</h2>

    <% if (request.getAttribute("msg") != null) { %>
    <div class="containerMessaggio" style="justify-content:center; margin-bottom: 15px;">
        <div id="messaggioConferma">
            <%= request.getAttribute("msg") %>
            <span class="chiudiMessaggio" onclick="this.parentElement.parentElement.style.display='none';">×</span>
        </div>
    </div>
    <% } %>

    <form method="POST" action="ModificaCredenzialiServlet" id="credenzialiForm">
        <span class="grassetto">Modifica username:</span><br>
        <input type="text" class="dati" id="username" name="username" placeholder="Inserisci nuovo username" value="<%= u.getNomeUtente() %>"><br>

        <span class="grassetto">Modifica password:</span><br>
        <input type="password" class="dati" id="oldpass" name="oldPassword" placeholder="Inserisci password attuale"><br>
        <span id="errorPass" class="formError">Password non valida</span><br>

        <input type="password" class="dati" id="newpass" name="newPassword" placeholder="Inserisci nuova password"><br>
        <span id="indicazionePass" class='tipPassword'>La password deve contenere almeno 3 caratteri (una lettera, un numero)</span><br>
        <span id="errorPass2" class="formError">Le password non corrispondono</span><br>

        <input type="password" class="dati" id="confpass" name="confirmPassword" placeholder="Conferma nuova password"><br>

        <input class="bottone" type="button" value="Modifica" onclick="controlloCampiCredenziali()">
    </form>
</div>

<script src="js/script.js"></script>  <!-- percorso corretto JS -->
</body>
</html>
