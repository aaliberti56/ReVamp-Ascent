<%--
  Created by IntelliJ IDEA.
  User: aless
  Date: 24/06/2025
  Time: 15:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="model.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Informazioni sulla consegna</title>
    <link rel="stylesheet" href="css/stileRegistrazione.css">
    <link rel="icon" type="image/x-icon" href="img/logo.webp">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<!-- jsp:include page="header.jsp"  -->    <!-- da implementare successivamente-->
<div class="errore">
    <img src="img/deliver.gif" class="imgerrore">
</div>
<div class="errore1">
    <h2>Informazioni sulla consegna</h2>
    <p>
        Le consegne vengono effettuate dal lunedì al venerdì tramite corriere GLS, UPS o Poste Italiane.<br>
        Spediamo i nostri prodotti in tutta Italia entro 2/3 giorni lavorativi. <br>
    </p>
</div>

<jsp:include page="footerAreaUtente.jsp"></jsp:include>

</body>
</html>
