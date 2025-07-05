<%--
  Created by IntelliJ IDEA.
  User: aless
  Date: 04/07/2025
  Time: 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.JavaBeans.Categoria, model.DAO.CategoriaDAO, java.util.List" %>

<html>
<head>
  <meta charset="UTF-8">
  <title>ReVamp Ascent</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@100;200;500;700&display=swap" rel="stylesheet">

  <style>
    .header-admin {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 15px 25px;
      background-color: #2c3e50;
      color: white;
      font-family: 'Raleway', sans-serif;
      box-shadow: 0 2px 8px rgba(0,0,0,0.2);
    }

    .header-admin .left {
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .header-admin .left img {
      height: 50px;
    }

    .header-admin .left h2 {
      margin: 0;
      font-size: 1.5em;
      font-weight: 700;
    }

    .header-admin .right {
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .header-admin .right span {
      font-weight: 500;
    }

    .admin-button {
      padding: 8px 16px;
      background-color: #3498db;
      color: white;
      border: none;
      border-radius: 6px;
      text-decoration: none;
      font-weight: bold;
      transition: background-color 0.3s;
    }

    .admin-button:hover {
      background-color: #2980b9;
    }

    @media (max-width: 768px) {
      .header-admin {
        flex-direction: column;
        align-items: flex-start;
        gap: 10px;
      }

      .header-admin .right {
        flex-direction: column;
        align-items: flex-start;
      }
    }
  </style>
</head>
<body>

<div class="header-admin">
  <div class="left">
    <a href="admin.jsp">
      <img src="img/logo.webp" alt="Logo Admin">
    </a>
    <h2>Pannello Amministratore</h2>
  </div>

  <div class="right">
    <a href="admin.jsp" class="admin-button">Home Admin</a>
    <a href="ordini.jsp" class="admin-button">Visualizza Ordini</a>
    <a href="AdminLogoutServlet" class="admin-button">Logout</a>
  </div>
</div>


</body>
</html>
