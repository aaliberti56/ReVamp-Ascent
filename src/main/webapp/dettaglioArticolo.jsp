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
    <link rel="stylesheet" href="css/stileRegistrazione.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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
        <div class="immagine-principale">
            <img id="imgPrincipale" class="immagine-articolo" src="<%= imgPrincipale %>" alt="Immagine principale articolo" />
        </div>

        <div class="galleria">
            <img src="<%= imgPrincipale %>" class="miniatura attiva" alt="Immagine principale miniatura"
                 onclick="cambiaImmaginePrincipale(this)" />
            <%
    for (String url : altreImmagini) {
        if (url != null && !url.trim().isEmpty()) {
%>
    <img src="<%= url %>" class="miniatura" alt="Miniatura immagine articolo" onclick="cambiaImmaginePrincipale(this)" />
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

        <p class="prezzo-articolo">
            Prezzo: € <%= String.format(Locale.ITALY, "%.2f", prezzoScontato) %>
            <% if (articolo.getSconto() > 0) { %>
            <del>€ <%= String.format(Locale.ITALY, "%.2f", articolo.getPrezzo()) %></del>
            <% } %>
        </p>

        <p><strong>Peso:</strong> <%= articolo.getPeso() %> kg</p>
        <p><strong>Dimensione:</strong> <%= articolo.getDimensione() %> cm</p>
    </div>

</div> <!-- fine contenitore-principale -->

<form action="CarrelloServlet" method="post" style="margin-top: 20px;">
    <input type="hidden" name="idArticolo" value="<%= articolo.getCodice() %>" />
    <button type="submit" style="background: none; border: none; cursor: pointer; padding: 0;">
        <img src="img/cart.png" alt="Aggiungi al carrello" style="width: 48px; height: 48px;" />
    </button>
</form>

<br>

<div class="recensioni">
    <h2>Recensioni</h2>

    <%
        if (recensioni == null || recensioni.isEmpty()) {
    %>
    <p>Nessuna recensione per questo articolo.</p>
    <%
    } else {
        for (Recensione r : recensioni) {
    %>
    <div class="recensione-singola">
        <strong><%= r.getNome_utente() != null ? r.getNome_utente() : "Anonimo" %></strong> -
        <small><%= r.getData() != null ? sdf.format(r.getData().getTime()) : "" %></small>
        <!-- Stelle -->
        <div class="stelle-valutazione">
            <% int voto = r.getValutazione(); %>
            <% for (int i = 1; i <= 5; i++) { %>
            <% if (i <= voto) { %>
            <i class="fa-solid fa-star" style="color: gold;"></i>
            <% } else { %>
            <i class="fa-regular fa-star" style="color: gold;"></i>
            <% } %>
            <% } %>
        </div>

        <p><%= r.getTesto() %></p>
    </div>
    <%
            }
        }
    %>
</div>

<%
    if (utenteLoggato != null) {
%>
<div class="scrivi-recensione">
    <h3>Lascia una recensione</h3>
    <form action="RecensioneServlet" method="post" class="scrivi-recensione-form">
        <div class="stelle" title="Vota con le stelle">
            <input type="radio" id="stella5" name="valutazione" value="5" /><label for="stella5">&#9733;</label>
            <input type="radio" id="stella4" name="valutazione" value="4" /><label for="stella4">&#9733;</label>
            <input type="radio" id="stella3" name="valutazione" value="3" /><label for="stella3">&#9733;</label>
            <input type="radio" id="stella2" name="valutazione" value="2" /><label for="stella2">&#9733;</label>
            <input type="radio" id="stella1" name="valutazione" value="1" /><label for="stella1">&#9733;</label>
        </div>

        <input type="text" name="titolo" placeholder="Scrivi un titolo accattivante..." required>
        <textarea name="testo" rows="5" placeholder="Racconta la tua esperienza con questo prodotto..." required></textarea>

        <button type="submit" class="btn"><i class="fa fa-pencil-alt"></i> Invia recensione</button>
    </form>

</div>

<%
} else {
%>
<p>Per scrivere una recensione devi essere <a href="login.jsp">loggato</a>.</p>
<%
    }
%>

<script>
    function cambiaImmaginePrincipale(img) {
        const imgPrincipale = document.getElementById('imgPrincipale');
        imgPrincipale.src = img.src;

        document.querySelectorAll('.galleria img.miniatura').forEach(el => el.classList.remove('attiva'));
        img.classList.add('attiva');
    }
</script>

<jsp:include page="footerAreaUtente.jsp"></jsp:include>

</body>
</html>





