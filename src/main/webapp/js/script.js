// Validazione form login
document.addEventListener("DOMContentLoaded", inizializzaLoginForm);

function inizializzaLoginForm() {
    const form = document.getElementById('formLogin');

    if (form) {
        form.addEventListener("submit", function (event) {
            if (!validazioneCampiLogin()) {
                event.preventDefault(); // Blocca l'invio del form
                mostraErroreLogin();
            } else {
                nascondiErroreLogin();
            }
        });
    }
}

function validazioneCampiLogin() {
    const username = document.getElementById('username')?.value.trim();
    const password = document.getElementById('password')?.value.trim();
    return username !== "" && password !== "";
}

function mostraErroreLogin() {
    const errore = document.getElementById('errorLogin');
    if (errore) {
        errore.style.display = "inline";
    }
}

function nascondiErroreLogin() {
    const errore = document.getElementById('errorLogin');
    if (errore) {
        errore.style.display = "none";
    }
}

// Chiudi messaggio di errore lato server
function nascondiMessaggio() {
    const container = document.querySelector('.containerMessaggio');
    if (container) {
        container.style.display = 'none';
    }
}

