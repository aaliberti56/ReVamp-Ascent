<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    model.JavaBeans.Cliente utente=(model.JavaBeans.Cliente) session.getAttribute("utenteLoggato");
    if(utente==null){
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifica Credenziali</title>
    <link rel="stylesheet" href="css/stileRegistrazione.css">
    <link rel="icon" type="image/x-icon" href="img/logo.webp">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<img src="img/logo.webp" class="logo">
<div id="contenitoreForm">
    <h2 class="titoloLogin">Modifica Credenziali</h2>
    <form action="ModificaCredenzialiServlet" method="post">
        <label>Username: </label>
        <input type="text" name="username" value=" <%=utente.getNomeUtente()%>" readonly><br><br>
        <label>Email:</label>
        <input type="email" name="email" value="<%= utente.getEmail() %>" required><br><br>

        <label>Vecchia Password:</label>
        <input type="password" name="oldPassword" required><br><br>

        <label>Nuova Password:</label>
        <input type="password" name="newPassword" required><br><br>
        <label>Conferma Nuova Password:</label>
        <input type="password" name="confirmPassword" required><br><br>

        <input type="submit" value="Aggiorna" class="bottone">
    </form>
    <%
        String msg = (String) request.getAttribute("msg");
        if (msg != null) {
    %>
    <p style="color: red;"><%= msg %></p>
    <%
        }
    %>
</div>

</body>
</html>

