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
    <link rel="icon" type="image/x-icon" href="img/logo.webp">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            font-family: 'Segoe UI', sans-serif;
            color: #333;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            text-align: center;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
        }

        .logo {
            width: 120px;
            height: auto;
            display: block;
            margin: 0 auto 20px auto;
        }

        h2 {
            font-size: 28px;
            margin-bottom: 10px;
        }

        h4 {
            margin-top: 5px;
            font-weight: normal;
            color: #666;
        }

        .button-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 40px;
        }

        .button-container a {
            text-decoration: none;
        }

        .admin-button {
            width: 260px;
            height: 120px;
            background-color: #007bff;
            border: none;
            border-radius: 12px;
            color: #ffffff;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .admin-button:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }

        @media (max-width: 600px) {
            .admin-button {
                width: 90%;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <img src="img/logo.webp" alt="Logo" class="logo">

    <h2>Benvenuto, <%= admin.getNome() %> <%= admin.getCognome() %>!</h2>
    <h4>Area riservata amministratore</h4>

    <div class="button-container">
        <a href="FormAggiungiArticoloServlet">
            <button class="admin-button">AGGIUNGI ARTICOLO</button>
        </a>
        <a href="Products.jsp">
            <button class="admin-button">MODIFICA/ELIMINA ARTICOLO</button>
        </a>
        <a href="Ordini.jsp">
            <button class="admin-button">VISUALIZZA LISTA ORDINI</button>
        </a>
        <a href="listaUtentiAdmin.jsp">
            <button class="admin-button">VISUALIZZA LISTA UTENTI</button>
        </a>
    </div>
</div>

</body>
</html>

