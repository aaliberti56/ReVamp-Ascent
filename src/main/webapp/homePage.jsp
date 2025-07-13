<%--
  Created by IntelliJ IDEA.
  User: aless
  Date: 13/07/2025
  Time: 12:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.DAO.ArticoloDAO, model.DAO.ImmagineArticoloDAO, model.DAO.CategoriaDAO" %>
<%@ page import="model.JavaBeans.Articolo, model.JavaBeans.ImmagineArticolo, model.JavaBeans.Categoria" %>
<%@ page import="java.util.*, java.math.BigDecimal" %>
<html>
<head>
    <link rel="stylesheet" href="css/homePage.css">
    <link rel="icon" type="image/x-icon" href="img/logo.webp">
    <title>ReVamp Ascent - Home</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        .hero-promo {
            background: url("<%= request.getContextPath() %>/img/heroPromo.png") no-repeat center center/cover;
            color: white;
            padding: 100px 20px;
            text-align: center;
        }

    </style>

</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<div class="hero-promo">
    <div class="hero-promo-content">
        <div class="etichetta">Nuova Collezione</div>
        <div class="spedizione">Spedizione Gratuita</div>
        <h1>Scopri i nuovi arrivi per ogni ambiente della tua casa</h1>
        <a href="catalogo.jsp" class="btn-approfitta">Scopri ora</a>
    </div>
</div>


<section class="spedizione">
    <h2>Benvenuto su ReVamp Ascent</h2>
    <p>
        Siamo il tuo punto di riferimento per arredamento moderno e funzionale.
        Trova mobili di design, illuminazione elegante e soluzioni per ogni stanza, selezionati con cura per dare nuova vita ai tuoi spazi.
    </p>
</section>

<div class="sconti-section">
    <h2>Approfittane Ora</h2>

    <div class="carousel-container">
        <button class="carousel-btn left" onclick="scrollCarousel(-1)">&#8592;</button>

        <div class="carousel" id="carousel">
            <%
                ArticoloDAO articoloDAO = new ArticoloDAO();
                ImmagineArticoloDAO imgDAO = new ImmagineArticoloDAO();
                List<Articolo> articoliScontati = articoloDAO.doRetrieveConSconto();

                for (Articolo articolo : articoliScontati) {
                    List<ImmagineArticolo> immagini = imgDAO.doRetrieveByArticolo(articolo.getCodice());
                    String imgPath = immagini != null && !immagini.isEmpty() ? immagini.get(0).getUrl() : "img/default.jpg";
                    double prezzoScontato = articolo.getPrezzo() * (1 - articolo.getSconto());
            %>
            <a class="card-prodotto" href="DettaglioArticoloServlet?codice=<%= articolo.getCodice() %>">
                <div class="badge-sconto">SALDI</div>
                <img src="<%= imgPath %>" alt="immagine">
                <h4><%= articolo.getNome() %></h4>
                <p>€ <%= String.format("%.2f", prezzoScontato) %></p>
            </a>


            <%
                }
            %>
        </div>

        <button class="carousel-btn right" onclick="scrollCarousel(1)">&#8594;</button>
    </div>
</div>



<section class="categorie-section">
<h2>Esplora per Categoria</h2>
<div class="categorie-grid">
    <%
        CategoriaDAO categoriaDAO=new CategoriaDAO();
        List<Categoria> categorie=categoriaDAO.doRetrieveAll();

        Map<String,String> immaginiCategoria=new HashMap<>();

        immaginiCategoria.put("Mobili", "img/mobili.png");
        immaginiCategoria.put("Sedie", "img/sedie.png");
        immaginiCategoria.put("Divani", "img/divani.png");
        immaginiCategoria.put("Letti", "img/letti.png");
        immaginiCategoria.put("Illuminazione", "img/illuminazione.png");
        immaginiCategoria.put("Tavolini", "img/tavolini.png");
        immaginiCategoria.put("Accessori", "img/accessori.png");
        immaginiCategoria.put("Esterni", "img/esterni.png");
        immaginiCategoria.put("Bambini", "img/bambini.png");

        for(Categoria categoria: categorie){
            String tipologia=categoria.getTipologia();
            String imgCat = immaginiCategoria.getOrDefault(tipologia, "img/default.jpg");
        %>

    <a href="catalogo.jsp?categ=<%=tipologia%>">
        <img src="<%= imgCat %>" alt="<%= tipologia %>">
        <span><%= tipologia %></span>
    </a>
    <%
        }
    %>
</div>
</section>

<jsp:include page="footerAreaUtente.jsp"></jsp:include>

<script>
    function scrollCarousel(direction){
        const carousel=document.getElementById('carousel');
        const scrollAmount=300;
        carousel.scrollBy({
            left: scrollAmount * direction, behavior: 'smooth'
        });
    }
</script>
</body>
</html>
