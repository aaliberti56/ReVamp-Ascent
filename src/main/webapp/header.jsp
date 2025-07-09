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
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    body { font-family: 'Raleway', sans-serif; margin: 0; padding: 0; }
    .logo { height: 60px; margin: 10px 20px; }
    .iconaMenu { height: 30px; margin: 0 10px; cursor: pointer; vertical-align: middle; }

    .menu-container {
      display: flex; justify-content: space-between; align-items: center;
      padding: 10px 20px; background-color: #f8f9fa; box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .menuricerca { display: flex; align-items: center; margin-left: auto; }
    .ricerca { padding: 8px 15px; border: 1px solid #ddd; border-radius: 20px; margin-right: 10px; width: 200px; }

    .menu { display: flex; background-color: #2c3e50; padding: 10px 20px; }
    .menu a { color: white; padding: 10px 15px; text-decoration: none; font-weight: 500; }
    .menu a:hover { background-color: #3d566e; }

    #menuTelefono { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: white; z-index: 1000; overflow-y: auto; padding: 20px; box-sizing: border-box; }
    .closeBtn { position: absolute; top: 20px; right: 20px; }
    .vociMenuTelefono { margin-top: 40px; }
    .vociMenuTelefono a { color: #2c3e50; font-weight: 700; font-size: 1.2em; display: block; margin: 15px 0; text-decoration: none; }
    #hamburgerMenu { display: none; }

    @media (max-width: 768px) {
      .menu { display: none; }
      #hamburgerMenu { display: inline-block; }
    }

    .iconaMenuBtn { background: none; border: none; padding: 0; cursor: pointer; }

    .modal-ricerca {
      display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 999;
      background-color: rgba(0, 0, 0, 0.6);
    }

    .modal-content-ricerca {
      background-color: white; margin: 10% auto; padding: 20px; border-radius: 10px;
      width: 80%; max-width: 500px; box-shadow: 0 4px 15px rgba(0,0,0,0.3); position: relative;
    }

    .close-ricerca { position: absolute; top: 10px; right: 15px; font-size: 24px; font-weight: bold; color: #333; cursor: pointer; }

    .modal-content-ricerca ul {
        list-style: none;
        padding: 0;
        max-height: 300px;
        overflow-y: auto;
    }
    .modal-content-ricerca li { margin-bottom: 10px; }
    .modal-content-ricerca a { text-decoration: none; color: #2c3e50; font-weight: 500; }
    .modal-content-ricerca a:hover { text-decoration: underline; }
    .btn-catalogo {
      background-color: #3498db;
      color: white;
      padding: 8px 14px;
      border-radius: 20px;
      text-decoration: none;
      font-weight: 500;
      margin-left: 15px;
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 0.95rem;
      transition: background-color 0.3s ease;
    }

    .btn-catalogo:hover {
      background-color: #2980b9;
    }

  </style>
</head>
<body>

<div class="menu-container">
  <a href="homePage.jsp">
    <img src='img/logo.webp' class='logo' alt="Logo">
  </a>


  <a href="catalogo.jsp" class="btn-catalogo">
    <i class="fa-solid fa-list"></i> Catalogo
  </a>


  <div class="menuricerca">
    <form id="formRicerca" onsubmit="eseguiRicerca(event)">
      <input type="text" id="textboxRicerca" name="ricerca" placeholder="Cerca un prodotto..." class="ricerca" required>
      <button type="submit" class="iconaMenuBtn">
        <img src="img/magnifier.png" alt="Cerca" class="iconaMenu">
      </button>
    </form>

  </div>


  <a href="carrello.jsp" style="text-decoration: none;">
    <img src="img/cart.png" class="iconaMenu" alt="Carrello">
  </a>

  <a href="home.jsp">
    <img src="img/user.png" class="iconaMenu" alt="Area Utente">
  </a>
</div>


<img src="img/menu.png" class="iconaMenu" onclick="mostraMenu()" id="hamburgerMenu" alt="Menu">

<!-- Modale risultati ricerca -->
<div id="modalRisultati" class="modal-ricerca">
  <div class="modal-content-ricerca">
    <span class="close-ricerca" onclick="chiudiModal()">&times;</span>
    <h3>Risultati della ricerca</h3>
    <ul id="listaProdottiModale"></ul>
  </div>
</div>

<!-- Menu mobile -->
<div id="menuTelefono">
  <img class="iconaMenu closeBtn" src="img/close.png" onclick="nascondiMenu()" alt="Chiudi">
  <h1 style='text-align: center;'>Categorie</h1>

  <div class="vociMenuTelefono">
    <%
      CategoriaDAO catdao = new CategoriaDAO();
      List<Categoria> categorie = catdao.doRetrieveAll();

      for (Categoria categoria : categorie) {
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

<!-- Menu desktop -->
<nav class='menu'>
  <%
    for (Categoria categoria : categorie) {
  %>
  <a href="catalogo.jsp?categ=<%= categoria.getTipologia() %>">
    <%= categoria.getTipologia() %>
  </a>
  <%
    }
  %>
</nav>

<script>
  function mostraMenu() {
    document.getElementById('menuTelefono').style.display = 'block';
  }

  function nascondiMenu() {
    document.getElementById('menuTelefono').style.display = 'none';
  }

  function eseguiRicerca(event) {
    event.preventDefault();

    const query = document.getElementById("textboxRicerca").value.trim();
    if (query === "") return;

    const xhr = new XMLHttpRequest();
    xhr.open("GET", "RicercaCatalogoJson?ricerca=" + encodeURIComponent(query), true);
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4 && xhr.status === 200) {
        try {
          const prodotti = JSON.parse(xhr.responseText);
          const ul = document.getElementById("listaProdottiModale");
          ul.innerHTML = "";

          if (prodotti.length === 0) {
            const li = document.createElement("li");
            li.textContent = "Nessun prodotto trovato.";
            ul.appendChild(li);
          } else {
            prodotti.forEach(p => {
              const li = document.createElement("li");
                li.innerHTML =
                    '<a href="DettaglioArticoloServlet?codice=' + p.codice + '" style="display: flex; align-items: center; gap: 10px;">' +
                    '<img src="' + p.immagine + '" alt="' + p.nome + '" style="width: 50px; height: 50px; object-fit: cover; border-radius: 5px;">' +
                    '<strong>' + p.nome + '</strong>' +
                    '</a> - €' + parseFloat(p.prezzo).toFixed(2);
                ul.appendChild(li);

            });
          }

          document.getElementById("modalRisultati").style.display = "block";
        } catch (e) {
          console.error("Errore JSON:", e);
        }
      }
    };
    xhr.send();
  }

  function chiudiModal() {
    document.getElementById("modalRisultati").style.display = "none";
  }
</script>
</body>
</html>

