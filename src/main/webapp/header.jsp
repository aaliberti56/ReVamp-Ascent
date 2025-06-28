<%--
  Created by IntelliJ IDEA.
  User: aless
  Date: 27/06/2025
  Time: 15:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.JavaBeans.Categoria, model.DAO.CategoriaDAO, java.util.List" %>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <title>ReVamp Ascent</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@100;200;500;700&display=swap" rel="stylesheet">
  <style>
    /* Stili generali */
    body {
      font-family: 'Raleway', sans-serif;
      margin: 0;
      padding: 0;
    }

    .logo {
      height: 60px;
      margin: 10px 20px;
    }

    .iconaMenu {
      height: 30px;
      margin: 0 10px;
      cursor: pointer;
      vertical-align: middle;
    }

    /* Menu principale */
    .menu-container {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 10px 20px;
      background-color: #f8f9fa;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .menuricerca {
      display: flex;
      align-items: center;
    }

    .ricerca {
      padding: 8px 15px;
      border: 1px solid #ddd;
      border-radius: 20px;
      margin-right: 10px;
      width: 200px;
    }

    .menu {
      display: flex;
      background-color: #2c3e50;
      padding: 10px 20px;
    }

    .menu a {
      color: white;
      padding: 10px 15px;
      text-decoration: none;
      font-weight: 500;
    }

    .menu a:hover {
      background-color: #3d566e;
    }

    /* Menu mobile (per dispositivi piccoli) */
    #menuTelefono {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: white;
      z-index: 1000;
      overflow-y: auto;
      padding: 20px;
      box-sizing: border-box;
    }

    .closeBtn {
      position: absolute;
      top: 20px;
      right: 20px;
    }

    .vociMenuTelefono {
      margin-top: 40px;
    }

    .vociMenuTelefono a {
      color: #2c3e50;
      font-weight: 700;
      font-size: 1.2em;
      display: block;
      margin: 15px 0;
      text-decoration: none;
    }

    #hamburgerMenu {
      display: none;
    }

    /* Responsive - quando lo schermo è piccolo */
    @media (max-width: 768px) {
      .menu {
        display: none;
      }

      #hamburgerMenu {
        display: inline-block;
      }

      .menuricerca {
        margin-left: auto;
      }
    }
  </style>
</head>
<body>

<div class="menu-container">
  <a href="catalogo.jsp">
    <img src='img/logo.webp' class='logo' alt="Logo">
  </a>

  <div class="menuricerca">
    <form action="RicercaCatalogo" method="GET">
      <input type="text" id="textboxRicerca" name="ricerca" placeholder=" Ricerca..." class="ricerca">
      <input type="image" src="img/magnifier.png" alt="Cerca" class="iconaMenu">
    </form>

    <a href="carrello.jsp" style="text-decoration: none;">
      <img src="img/cart.png" class="iconaMenu" alt="Carrello">
    </a>

    <a href="home.jsp">
      <img src="img/user.png" class="iconaMenu" alt="Area Utente">
    </a>
  </div>

  <img src="img/menu.png" class="iconaMenu" onclick="mostraMenu()" id="hamburgerMenu" alt="Menu">
</div>

<!-- Menu mobile - appare solo su dispositivi piccoli -->
<div id="menuTelefono">
  <img class="iconaMenu closeBtn" src="img/close.png" onclick="nascondiMenu()" alt="Chiudi">
  <h1 style='text-align: center;'>Categorie</h1>

  <div class="vociMenuTelefono">
    <%
      CategoriaDAO catdao = new CategoriaDAO();
      List<Categoria> categorie = catdao.doRetrieveAll();

      for(Categoria categoria : categorie) {
    %>
    <a href="catalogo.jsp?categ=<%= categoria.getTipologia() %>">
      <%= categoria.getTipologia() %>
    </a>
    <%
      }
    %>

    <div style="margin-top: 30px; text-align: center;">
      <a href="carrello.jsp" style="text-decoration: none;">
        <img src="img/cart.png" class="iconaMenu" alt="Carrello">
      </a>

      <a href="home.jsp">
        <img src="img/user.png" class="iconaMenu" alt="Area Utente">
      </a>
    </div>
  </div>
</div>

<!-- Menu desktop - appare su schermi grandi -->
<nav class='menu'>
  <%
    for(Categoria categoria : categorie) {
  %>
  <a href="catalogo.jsp?categ=<%= categoria.getTipologia() %>">
    <%= categoria.getTipologia() %>
  </a>
  <%
    }
  %>
</nav>

<script>
  // Funzioni per mostrare/nascondere il menu mobile
  function mostraMenu() {
    document.getElementById('menuTelefono').style.display = 'block';
  }

  function nascondiMenu() {
    document.getElementById('menuTelefono').style.display = 'none';
  }

  // Ricerca dinamica (opzionale)
  document.getElementById('textboxRicerca').addEventListener('input', function() {
    var testoRicerca = this.value;
    if(testoRicerca.length > 2) {
      // Puoi implementare qui la ricerca dinamica
      // usando fetch() o XMLHttpRequest
    }
  });
</script>
</body>
</html>
