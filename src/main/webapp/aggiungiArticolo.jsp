<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.JavaBeans.Categoria" %>
<%@ page import="java.util.List" %>

<%
  if (session.getAttribute("admin") == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  List<Categoria> categorie = (List<Categoria>) request.getAttribute("categorie");
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Aggiungi Articolo</title>
  <link rel="stylesheet" href="css/stileRegistrazione.css">
  <link rel="icon" href="img/logo.webp" type="image/x-icon">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<body>

<jsp:include page="headerAdmin.jsp" />

<img src="img/logo.webp" class="logo">

<div id="contenitoreForm">
  <h2 class="titoloLogin">Inserisci un nuovo articolo</h2>

  <form action="AggiungiArticoloServlet" id="formId" method="post" enctype="multipart/form-data">
    <input type="number" name="codice" placeholder="Codice Articolo" class="dati" required><br>
    <input type="text" name="nome" placeholder="Nome" class="dati" required><br>
    <textarea name="descrizione" placeholder="Descrizione" class="dati" required></textarea><br>
    <input type="text" name="colore" placeholder="Colore" class="dati"><br>
    <input type="number" name="sconto" step="0.01" placeholder="Sconto (%)" class="dati"><br>
    <input type="number" name="prezzo" step="0.01" placeholder="Prezzo (€)" class="dati" required><br>
    <input type="number" name="peso" step="0.001" placeholder="Peso (kg)" class="dati"><br>
    <input type="text" name="dimensione" placeholder="Dimensione" class="dati"><br>

    <!-- Upload immagine -->
    <div class="upload-box">
      <label class="upload-label">Immagine articolo (JPG max 2MB)</label>
      <input type="file"
             id="immagine"
             name="immagine"
             accept=".jpg,.jpeg"
             required
             class="upload-input">

      <div class="preview-box">
        <img id="previewImg" style="display:none;">
        <div id="previewPlaceholder">Nessuna immagine selezionata</div>
      </div>
    </div>

    <!-- RISULTATO AI -->
    <div id="aiResult">
      🧠 Categoria predetta: <span id="aiCategory"></span><br>
      <small id="aiConfidence"></small>
    </div>

    <!-- Campo nascosto che la servlet leggerà -->
    <input type="hidden" name="id_categoria" id="id_categoria_ai">

    <input type="submit" value="Aggiungi Articolo" class="bottone">
  </form>
</div>

<script>
  const fileInput = document.getElementById("immagine");
  const previewImg = document.getElementById("previewImg");
  const placeholder = document.getElementById("previewPlaceholder");

  const aiBox = document.getElementById("aiResult");
  const aiCategory = document.getElementById("aiCategory");
  const aiConfidence = document.getElementById("aiConfidence");
  const hiddenCategory = document.getElementById("id_categoria_ai");

  // mapping ING → IT + ID DB
  const categoryMap = {
    bed:    { nome: "Letti",   id: 1 },
    chair:  { nome: "Sedie",   id: 2 },
    sofa:   { nome: "Divani",  id: 3 },
    table:  { nome: "Tavoli",  id: 4 }
  };

  fileInput.addEventListener("change", async () => {
    const file = fileInput.files[0];
    if (!file) return;

    // preview immagine
    const reader = new FileReader();
    reader.onload = e => {
      previewImg.src = e.target.result;
      previewImg.style.display = "block";
      placeholder.style.display = "none";
    };
    reader.readAsDataURL(file);

    // chiamata AI
    aiBox.style.display = "block";
    aiCategory.textContent = "Analisi in corso...";
    aiConfidence.textContent = "";

    const formData = new FormData();
    formData.append("image", file);

    try {
      const res = await fetch("http://127.0.0.1:5000/predict", {
        method: "POST",
        body: formData
      });

      const data = await res.json();
      const cat = categoryMap[data.category];

      aiCategory.textContent = cat.nome;
      aiConfidence.textContent = "Confidenza: " + Math.round(data.probabilities[data.category]*100) + "%";

      hiddenCategory.value = cat.id;

    } catch (e) {
      aiCategory.textContent = "Errore AI";
      aiConfidence.textContent = "Servizio non disponibile";
    }
  });
</script>

</body>
</html>

