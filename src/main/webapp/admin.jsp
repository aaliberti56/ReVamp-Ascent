<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.JavaBeans.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("../loginAdmin.jsp?errore=true");
        return;
    }
%>

<html>
<head>
    <title>Area Admin</title>
    <link rel="stylesheet" href="css/stileRegistrazione.css"> <!-- Se vuoi mantenere lo stile -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<h2>Benvenuto, <%= admin.getNome() %> <%= admin.getCognome() %>!</h2>
<p>Username: <%= admin.getUsername() %></p>

<hr>

<!-- Bottone per aggiungere articoli -->
<div style="margin-bottom: 20px;">
    <a href="aggiungiArticolo.jsp" class="bottone" style="text-decoration:none; padding:12px 24px; display:inline-block;">
        Aggiungi Articoli
    </a>
</div>

<a href="../LogoutServlet" class="bottone" style="background-color:#999; text-decoration:none; padding:12px 24px; display:inline-block;">
    Logout
</a>

</body>
</html>
