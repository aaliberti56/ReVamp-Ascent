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
  <link rel="stylesheet" href="css/header.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@100;200;500;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<div class="menu-container">

  <!-- BLOCCO SINISTRA -->
  <div class="blocco-sinistra">
    <a href="homePage.jsp">
      <img src='img/logo.webp' class='logo' alt="Logo">
    </a>

    <a href="catalogo.jsp" class="btn-catalogo">
      <i class="fa-solid fa-list"></i> Catalogo
    </a>

    <div class="menuricerca">
      <form id="formRicerca" class="barra-ricerca" onsubmit="eseguiRicerca(event)">
        <input type="text" id="textboxRicerca" name="ricerca" placeholder="Cerca un prodotto..." required>
        <button type="submit"><i class="fa fa-search"></i></button>
      </form>
    </div>
  </div>

  <!-- BLOCCO DESTRA -->
  <div class="icone-destra">
    <a href="home.jsp" class="account-link">
      <img src="img/user.png" class="iconaAccount" alt="Account">
      <div class="testo-account">
        Il mio account<br><strong>Accedi</strong>
      </div>
    </a>

    <a href="carrello.jsp" class="carrello-link">
      <img src="img/cart.png" alt="Carrello" width="28">
      <span id="carrello-badge" class="badge-carrello" style="display:none;">0</span>
    </a>
  </div>


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
        <img src="<%= request.getContextPath() %>/img/cart.png" class="iconaMenu" alt="Carrello">
      </a>

      <a href="home.jsp" class="account-link">
        <img src="img/user.png" class="iconaAccount" alt="Account">
        <div class="testo-account">
          Il mio account<br><strong>Accedi</strong>
        </div>
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

