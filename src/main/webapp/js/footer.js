document.addEventListener('DOMContentLoaded', () => {
    const modal = document.getElementById("modalIscrizione");
    const btn = document.getElementById("btnIscriviti");
    const span = modal.querySelector(".close");
    const emailInput = document.getElementById("newsletterEmail");

    btn.onclick = () => {
        if (emailInput.value.trim() === "") {
            alert("Inserisci una email valida!");
            return;
        }
        modal.style.display = "block";
        emailInput.value = "";
    };

    span.onclick = () => {
        modal.style.display = "none";
    };

    window.onclick = (event) => {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    };
});
