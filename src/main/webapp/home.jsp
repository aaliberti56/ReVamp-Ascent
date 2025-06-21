<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.JavaBeans.Cliente" %>
<%@ page session="true" %>

<%
    Cliente utente = (Cliente) session.getAttribute("utenteLoggato");
    if (utente == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Home - Benvenuto <%= utente.getNome() %></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f8fa;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        header {
            background-color: #007a99;
            color: white;
            padding: 15px 20px;
            border-radius: 5px;
        }
        h2 {
            margin: 0;
        }
        .container {
            margin-top: 30px;
        }
        .saldo {
            font-size: 1.2em;
            margin-bottom: 20px;
        }
        a.button {
            background-color: #007a99;
            color: white;
            text-decoration: none;
            padding: 12px 20px;
            border-radius: 4px;
            margin-right: 10px;
            transition: background-color 0.3s ease;
        }
        a.button:hover {
            background-color: #005f73;
        }
    </style>
</head>
<body>
<header>
    <h2>Benvenuto, <%= utente.getNome() %>!</h2>
</header>
<div class="container">
    <p class="saldo">Saldo disponibile: € <%= String.format("%.2f", utente.getSaldo()) %></p>
    <a class="button" href="VisualizzaArticoliServlet">Vai allo shop</a>
    <a class="button" href="LogoutServlet">Logout</a>
</div>
</body>
</html>
