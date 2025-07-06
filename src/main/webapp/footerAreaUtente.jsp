<%--
  Created by IntelliJ IDEA.
  User: aless
  Date: 24/06/2025
  Time: 14:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="css/footer.css">
<style>
    .modal-content {
        background-color: white;
        color: black !important;
        padding: 30px;
        border-radius: 10px;
        font-size: 18px;
        text-align: center;
    }

    #testoModal {
        display: block !important;
        color: black !important;
        font-size: 20px !important;
        opacity: 1 !important;
        visibility: visible !important;
        z-index: 9999 !important;
        margin: 0;
    }

    .news {
        background: linear-gradient(to right, #ef6848, #ff9966);
        color: black;
        text-align: center;
        padding: 40px 20px;
    }


    .news h2 {
        color: black;
        font-size: 28px;
        margin-bottom: 10px;
    }

    .news p {
        color: black;
        font-size: 16px;
        margin-bottom: 20px;
    }

</style>
<footer class="footer">
    <div class="news">
        <h2>Iscriviti alla Newsletter</h2>
        <p>Ricevi offerte e aggiornamenti direttamente nella tua email.</p>
        <input type="email" placeholder="Inserisci la tua email" id="newsletterEmail" class="barra"><br>
        <button id="btnIscriviti" class="bottone">Iscriviti</button>
    </div>

    <div id="modalIscrizione" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <p id="testoModal">Iscrizione avvenuta con successo!</p>
        </div>
    </div>

    <div class="underFooter">
        <div class="info">
            <a href="contattaci.jsp" class="link"><span class="voceFooter">Contattaci</span></a><br><br>
            <a href="chisiamo.jsp" class="link"><span class="voceFooter">Chi siamo</span></a><br><br>
            <a href="infoConsegna.jsp" class="link"><span class="voceFooter">Informazioni sulla consegna</span></a><br><br>
            Metodi di pagamento: <br><br>
            <div class="fotopagamento">
                <img src="img/visa.jpg" class="fotopag">
                <img src="img/mastercard.jpg" class="fotopag">
                <img src="img/paypal.jpg" class="fotopag">
            </div>
        </div>
        <div class="info2">
            <img src="img/social.png" class="socialLogo">
        </div>
    </div>
</footer>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const modal = document.getElementById("modalIscrizione");
        const btn = document.getElementById("btnIscriviti");
        const span = modal.querySelector(".close");
        const emailInput = document.getElementById("newsletterEmail");
        const testoModal = document.getElementById("testoModal");

        btn.onclick = () => {
            if (emailInput.value.trim() === "") {
                alert("Inserisci una email valida!");
                return;
            }

            testoModal.textContent = "Iscrizione avvenuta con successo!";
            modal.style.display = "block";
            emailInput.value = "";
        };

        span.onclick = () => {
            modal.style.display = "none";
        };

        window.onclick = (event) => {
            if (event.target === modal) {
                modal.style.display = "none";
            }
        };
    });
</script>
