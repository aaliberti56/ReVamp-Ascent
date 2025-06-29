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

    <div class="underFooter">
        <br><br>
        <div class="info">
            <a href="contattaci.jsp" class="link"><span class="voceFooter">Contattaci</span></a><br><br>
            <a href="chisiamo.jsp" class="link"><span class="voceFooter">Chi siamo</span></a><br><br>
            <a href="infoConsegna.jsp" class="link"><span class="voceFooter">Informazioni sulla consegna</span></a><br><br>
            Metodi di pagamento: <br><br>
            <div class="fotopagamento">
                <img src="img/visa.jpg" class="fotopag">
                <img src="img/mastercard.jpg" class="fotopag">
                <img src="img/paypal.jpg" class="fotopag">
        </div>
    </div>
        <div class="info2">
            <img src="img/social.png" class="socialLogo">
        </div>
    </div>

</footer>

</body>
<script src="js/footer.js"></script>
</html>
