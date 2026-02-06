<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <title>Inserimento Automatico AI</title>

    <style>
        body { font-family: Inter, sans-serif; background: #f6f9fc; }

        .box {
            max-width: 950px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 14px;
            box-shadow: 0 8px 20px rgba(0,0,0,.08);
        }

        img.preview {
            max-width: 300px;
            margin: 20px auto;
            display: block;
            border-radius: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        .eye-btn {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1.2rem;
        }

        .details {
            background: #f9fafb;
            padding: 15px;
            text-align: left;
        }

        .field {
            margin-bottom: 10px;
        }

        .field label {
            font-size: 0.8rem;
            color: #555;
            display: block;
        }

        .field input, .field textarea {
            width: 100%;
            padding: 6px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        button.submit {
            margin-top: 25px;
            padding: 14px;
            width: 100%;
            background: #2ecc71;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            display: none;
        }
    </style>
</head>

<body>
<jsp:include page="headerAdmin.jsp"/>

<div class="box">
    <h2>🤖 Inserimento automatico articoli (YOLO)</h2>

    <input type="file" id="imageInput" accept="image/*">
    <img id="preview" class="preview" style="display:none;">

    <p id="loading" style="display:none; font-weight:bold;">⏳ Analisi AI in corso...</p>

    <form action="InserimentoAutomaticoServlet" method="post">
        <table>
            <thead>
            <tr>
                <th>Immagine</th>
                <th>Categoria</th>
                <th>Confidenza</th>
                <th>Modifica</th>
            </tr>
            </thead>
            <tbody id="itemsTable"></tbody>
        </table>

        <input type="hidden" name="itemsJson" id="itemsJson">
        <button type="submit" class="submit" id="submitBtn">
            ✅ Conferma inserimento articoli
        </button>
    </form>
</div>

<script>
    const input = document.getElementById("imageInput");
    const preview = document.getElementById("preview");
    const table = document.getElementById("itemsTable");
    const loading = document.getElementById("loading");
    const jsonInput = document.getElementById("itemsJson");
    const submitBtn = document.getElementById("submitBtn");

    let items = [];

    input.addEventListener("change", async function () {
        const file = input.files[0];
        if (!file) return;

        preview.src = URL.createObjectURL(file);
        preview.style.display = "block";

        loading.style.display = "block";
        table.innerHTML = "";
        items = [];
        submitBtn.style.display = "none";

        const fd = new FormData();
        fd.append("image", file);

        const res = await fetch("http://127.0.0.1:5000/detect-yolo-crop", {
            method: "POST",
            body: fd
        });

        const data = await res.json();
        loading.style.display = "none";

        if (!data.detections || data.detections.length === 0) {
            table.innerHTML =
                "<tr><td colspan='4'>Nessun articolo individuato</td></tr>";
            return;
        }

        data.detections.forEach(function (det, index) {

            items.push({
                name: det.category,
                category: det.category,
                description: "Inserito automaticamente",
                price: 100,
                quantity: 1,
                image_url: det.image_url
            });

            const percent = (det.confidence * 100).toFixed(1);

            table.innerHTML +=
                "<tr>" +
                "<td><img src='http://127.0.0.1:5000" + det.image_url + "' width='100'></td>" +
                "<td>" + det.category + "</td>" +
                "<td>" + percent + "%</td>" +
                "<td><button type='button' class='eye-btn' onclick='toggle(" + index + ")'>👁️</button></td>" +
                "</tr>" +

                "<tr id='details-" + index + "' style='display:none;'>" +
                "<td colspan='4' class='details'>" +

                "<div class='field'>" +
                "<label>Nome</label>" +
                "<input value='" + det.category + "' oninput='items[" + index + "].name=this.value'>" +
                "</div>" +

                "<div class='field'>" +
                "<label>Descrizione</label>" +
                "<textarea rows='2' oninput='items[" + index + "].description=this.value'>Inserito automaticamente</textarea>" +
                "</div>" +

                "<div class='field'>" +
                "<label>Prezzo (€)</label>" +
                "<input type='number' step='0.01' value='100' oninput='items[" + index + "].price=this.value'>" +
                "</div>" +

                "<div class='field'>" +
                "<label>Quantità</label>" +
                "<input type='number' value='1' oninput='items[" + index + "].quantity=this.value'>" +
                "</div>" +

                "</td></tr>";
        });

        jsonInput.value = JSON.stringify(items);
        submitBtn.style.display = "block";
    });

    function toggle(i) {
        const row = document.getElementById("details-" + i);
        row.style.display = (row.style.display === "none") ? "table-row" : "none";
    }

    document.querySelector("form").addEventListener("submit", function () {
        jsonInput.value = JSON.stringify(items);
    });
</script>

</body>
</html>