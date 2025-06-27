<%--
  Created by IntelliJ IDEA.
  User: aless
  Date: 24/06/2025
  Time: 18:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Contattaci</title>
    <link rel="stylesheet" href="css/stileRegistrazione.css">
    <link rel="icon" type="image/x-icon" href="img/logo.webp">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<div class="errore">
    <img src="img/phone.gif" class="imgerrore">
</div>
<br>
<br>

<div class="contatti" >
    <span class="grassetto">E-mail: info@revamp.it</span>
    <span class="grassetto">Telefono: 0123456789</span>
</div>

<jsp:include page="footerAreaUtente.jsp"></jsp:include>


</body>
</html>
