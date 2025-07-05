<%--
  Created by IntelliJ IDEA.
  User: aless
  Date: 29/06/2025
  Time: 17:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat, model.JavaBeans.Articolo, model.JavaBeans.ImmagineArticolo, model.JavaBeans.Recensione, model.JavaBeans.Cliente" %>
<%
    Articolo articolo = (Articolo) request.getAttribute("articolo");
    if (articolo == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<ImmagineArticolo> immagini = (List<ImmagineArticolo>) request.getAttribute("immagini");
    List<Recensione> recensioni = (List<Recensione>) request.getAttribute("recensioni");
    Cliente utenteLoggato = (Cliente) session.getAttribute("utenteLoggato");

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Dettaglio Articolo - <%= articolo.getNome() %></title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/stileRegistrazione.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .stelle-valutazione i.fa-star {
            color: gold;
        }
        .add-to-cart-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 30px;
        }
        .add-to-cart-container p {
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
            font-size: 1.1rem;
        }
        .add-to-cart-container button:hover img {
            transform: scale(1.1);
            transition: transform 0.2s ease-in-out;
        }
        .zoom-container {
            position: relative;
            cursor: pointer;
        }
        .zoom-container img {
            transition: transform 0.3s ease;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.8);
        }
        .modal-content {
            display: block;
            margin: 5% auto;
            max-width: 90%;
            max-height: 80vh;
        }
        .close {
            position: absolute;
            top: 20px;
            right: 35px;
            color: #fff;
            font-size: 40px;
            font-weight: bold;
            cursor: pointer;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<%
    double prezzoScontato = articolo.getPrezzo() - (articolo.getPrezzo() * articolo.getSconto() / 100.0);
    String imgPrincipale = "img/default.jpg";
    List<String> altreImmagini = new ArrayList<>();
    if (immagini != null && !immagini.isEmpty()) {
        for (ImmagineArticolo img : immagini) {
            String urlImg = img.getUrl();
            if (img.isIs_principale()) {
                imgPrincipale = urlImg;
            } else {
                altreImmagini.add(urlImg);
            }
        }
        if ("img/default.jpg".equals(imgPrincipale) && !immagini.isEmpty()) {
            imgPrincipale = immagini.get(0).getUrl();
        }
    }
%>

<div class="contenitore-principale">
    <div class="immagini-articolo">
        <div class="immagine-principale zoom-container" onclick="apriZoom()">
            <img id="imgPrincipale" class="immagine-articolo" src="<%= imgPrincipale %>" alt="Immagine principale articolo" />
        </div>
        <div class="galleria">
            <img src="<%= imgPrincipale %>" class="miniatura attiva" alt="Miniatura" onclick="cambiaImmaginePrincipale(this)" />
            <%
                for (String url : altreImmagini) {
                    if (url != null && !url.trim().isEmpty()) {
            %>
            <img src="<%= url %>" class="miniatura" alt="Miniatura" onclick="cambiaImmaginePrincipale(this)" />
            <%
                    }
                }
            %>
        </div>
    </div>

    <div class="info-articolo">
        <h2><%= articolo.getNome() %></h2>
        <p><%= articolo.getDescrizione() %></p>
        <p><strong>Colore:</strong> <%= articolo.getColore() %></p>
        <p class="prezzo-articolo">Prezzo: € <%= String.format(Locale.ITALY, "%.2f", prezzoScontato) %>
            <% if (articolo.getSconto() > 0) { %>
            <del>€ <%= String.format(Locale.ITALY, "%.2f", articolo.getPrezzo()) %></del>
            <% } %>
        </p>
        <p><strong>Peso:</strong> <%= articolo.getPeso() %> kg</p>
        <p><strong>Dimensione:</strong> <%= articolo.getDimensione() %> cm</p>
    </div>
</div>

<div class="add-to-cart-container">
    <p>Clicca sull'icona per aggiungere al carrello</p>
    <form action="CarrelloServlet" method="post">
        <input type="hidden" name="idArticolo" value="<%= articolo.getCodice() %>" />
        <button type="submit" style="background: none; border: none; cursor: pointer;">
            <img src="img/cart.png" alt="Aggiungi al carrello" style="width: 48px; height: 48px;" />
        </button>
    </form>
</div>

<div class="recensioni">
    <h2>Recensioni</h2>
    <% if (recensioni == null || recensioni.isEmpty()) { %>
    <p>Nessuna recensione per questo articolo.</p>
    <% } else {
        for (Recensione r : recensioni) { %>
    <div class="recensione-singola">
        <strong><%= r.getNome_utente() != null ? r.getNome_utente() : "Anonimo" %></strong>
        <small> - <%= r.getData() != null ? sdf.format(r.getData().getTime()) : "" %></small>
        <div class="stelle-valutazione">
            <% int voto = r.getValutazione();
                for (int i = 1; i <= 5; i++) {
                    if (i <= voto) { %>
            <i class="fa-solid fa-star"></i>
            <% } else { %>
            <i class="fa-regular fa-star"></i>
            <% }
            } %>
        </div>
        <p><%= r.getTesto() %></p>
    </div>
    <% } } %>
</div>

<% if (utenteLoggato != null) { %>
<div class="scrivi-recensione">
    <h3>Lascia una recensione</h3>
    <form action="RecensioneServlet" method="post">
        <input type="hidden" name="idArticolo" value="<%= articolo.getCodice() %>">
        <div class="stelle" title="Vota con le stelle">
            <input type="radio" id="stella5" name="valutazione" value="5"><label for="stella5">&#9733;</label>
            <input type="radio" id="stella4" name="valutazione" value="4"><label for="stella4">&#9733;</label>
            <input type="radio" id="stella3" name="valutazione" value="3"><label for="stella3">&#9733;</label>
            <input type="radio" id="stella2" name="valutazione" value="2"><label for="stella2">&#9733;</label>
            <input type="radio" id="stella1" name="valutazione" value="1"><label for="stella1">&#9733;</label>
        </div>
        <input type="text" name="titolo" placeholder="Scrivi un titolo..." required>
        <textarea name="testo" rows="5" placeholder="Racconta la tua esperienza con questo prodotto..." required></textarea>
        <button type="submit" class="btn"><i class="fa fa-pencil-alt"></i> Invia recensione</button>
    </form>
</div>
<% } else { %>
<p style="text-align: center; margin-top: 30px;">Per scrivere una recensione devi essere <a href="login.jsp">loggato</a>.</p>
<% } %>

<!-- Modale Zoom -->
<div id="modalZoom" class="modal" onclick="chiudiZoom()">
    <span class="close" onclick="chiudiZoom()">&times;</span>
    <img class="modal-content" id="imgZoom">
</div>

<script>
    function cambiaImmaginePrincipale(img) {
        const imgPrincipale = document.getElementById('imgPrincipale');
        imgPrincipale.src = img.src;
        document.querySelectorAll('.galleria img.miniatura').forEach(el => el.classList.remove('attiva'));
        img.classList.add('attiva');
    }

    function apriZoom() {
        const modal = document.getElementById("modalZoom");
        const zoomImg = document.getElementById("imgZoom");
        const imgPrincipale = document.getElementById("imgPrincipale");
        zoomImg.src = imgPrincipale.src;
        modal.style.display = "block";
    }

    function chiudiZoom() {
        document.getElementById("modalZoom").style.display = "none";
    }
</script>

<jsp:include page="footerAreaUtente.jsp"></jsp:include>
</body>
</html>



