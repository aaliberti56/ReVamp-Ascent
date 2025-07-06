let modal;
document.addEventListener('DOMContentLoaded', () => {
    modal = document.getElementById("modalIscrizione");
    window.modal = modal; // ora è accessibile anche da console
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

