<%--
  Created by IntelliJ IDEA.
  User: aless
  Date: 24/06/2025
  Time: 14:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="css/footer.css">
    <meta charset="UTF-8">
    <title>Footer</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/x-icon" href="img/logo.webp">
</head>
<body>
<footer class="footer">
    <div class="news">
        <h2>Iscriviti alla Newsletter</h2>
        <p>Ricevi offerte e aggiornamenti direttamente nella tua email.</p>
        <input type="email" placeholder="Inserisci la tua email" id="newsletterEmail" class="barra"><br>
        <button id="btnIscriviti" class="bottone">Iscriviti</button>
    </div>

    <div id="modalIscrizione" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <p>Iscrizione avvenuta con successo!</p>
        </div>
    </div>

    <div class="linksFooter">
        <a href="contattaci.jsp" class="linkFooter">Contattaci</a>
        <a href="chisiamo.jsp" class="linkFooter">Chi siamo</a>
        <a href="infoConsegna.jsp" class="linkFooter">Informazioni sulla consegna</a>
        <span class="linkFooter">Recensioni</span>
        <div class="pagamentiFooter">
            <p>Metodi di pagamento</p><br>
            <img src="img/visa.jpg" alt="Visa" class="fotoPag" />
            <img src="img/mastercard.jpg" alt="Mastercard" class="fotoPag" />
            <img src="img/paypal.jpg" alt="Paypal" class="fotoPag" />
        </div>
    </div>
    <div class="socialFooter">
        <img src="img/social.png" alt="Social" class="socialLogo" />
    </div>
</footer>
</body>
<script src="js/footer.js"></script>
</html>
