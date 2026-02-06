<%--
  Created by IntelliJ IDEA.
  User: aless
  Date: 03/02/2026
  Time: 17:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.JavaBeans.Admin" %>

<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%@ include file="headerAdmin.jsp" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Scelta Inserimento Articolo</title>
    <link rel="icon" type="image/x-icon" href="img/logo.webp">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        body {
            background-color: #f6f9fc;
            font-family: 'Inter', sans-serif;
        }

        .container {
            max-width: 900px;
            margin: 60px auto;
            text-align: center;
            animation: fadeIn 0.6s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            font-size: 2.2rem;
            color: #2c3e50;
            margin-bottom: 10px;
        }

        p.subtitle {
            color: #666;
            margin-bottom: 50px;
            font-size: 1.1rem;
        }

        .choice-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 40px;
        }

        .choice-card {
            background: white;
            border-radius: 18px;
            padding: 40px 30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            text-decoration: none;
            color: #2c3e50;
            border: 1px solid #e3e8ee;
        }

        .choice-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 16px 35px rgba(0,0,0,0.12);
        }

        .choice-icon {
            width: 80px;
            height: 80px;
            margin-bottom: 25px;
        }

        .choice-card h3 {
            font-size: 1.4rem;
            margin-bottom: 15px;
        }

        .choice-card p {
            font-size: 1rem;
            color: #555;
            line-height: 1.5;
        }

        .manual {
            border-top: 6px solid #3498db;
        }

        .auto {
            border-top: 6px solid #9b59b6;
        }
    </style>
</head>

<body>

<div class="container">
    <h2>Inserimento nuovo articolo</h2>
    <p class="subtitle">
        Scegli come aggiungere il prodotto al catalogo
    </p>

    <div class="choice-grid">

        <!-- AGGIUNTA MANUALE -->
        <a href="FormAggiungiArticoloServlet" class="choice-card manual">
            <img src="img/menu2.png" class="choice-icon" alt="Manuale">
            <h3>Aggiunta Manuale</h3>
            <p>
                Inserisci manualmente tutti i dati del prodotto
                e carica un’immagine singola.
            </p>
        </a>

        <!-- AGGIUNTA AUTOMATICA (AI) -->
        <a href="aggiungiArticoloAI.jsp" class="choice-card auto">
            <img src="img/menu1.png" class="choice-icon" alt="AI">
            <h3>Aggiunta Automatica (AI)</h3>
            <p>
                Carica una foto con più articoli.
                Il sistema rileva automaticamente i prodotti tramite YOLO.
            </p>
        </a>

    </div>
</div>

</body>
</html>
