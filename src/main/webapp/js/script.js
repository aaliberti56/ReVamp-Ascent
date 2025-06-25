// Inizializzazione validazione login e modifica credenziali
document.addEventListener("DOMContentLoaded", () => {
    inizializzaLoginForm();
    inizializzaFormModificaCredenziali();
});

// === VALIDAZIONE FORM LOGIN ===
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

// === VALIDAZIONE FORM MODIFICA CREDENZIALI ===
function inizializzaFormModificaCredenziali() {
    const formModifica = document.getElementById('formModificaCredenziali');
    if (formModifica) {
        formModifica.addEventListener("submit", function (event) {
            if (!validazioneModificaCredenziali()) {
                event.preventDefault();
            }
        });
    }
}


// === CHIUSURA MESSAGGIO SERVER ===
function nascondiMessaggio() {
    const container = document.querySelector('.containerMessaggio');
    if (container) {
        container.style.display = 'none';
    }
}
function controlloCampiCredenziali() {
    const username = document.getElementById('username').value.trim();
    const oldpass = document.getElementById('oldpass').value.trim();
    const newpass = document.getElementById('newpass').value.trim();
    const confpass = document.getElementById('confpass').value.trim();

    let valido = true;

    if (username === '') {
        alert('Username non può essere vuoto');
        valido = false;
    }

    if (oldpass === '') {
        alert('Inserisci la password attuale');
        valido = false;
    }

    // Cambiamento qui: simbolo NON obbligatorio
    if (newpass.length < 3 || !(/[a-zA-Z]/.test(newpass)) || !(/\d/.test(newpass))) {
        alert('La password deve contenere almeno 3 caratteri, inclusa almeno una lettera e un numero');
        valido = false;
    }

    if (newpass !== confpass) {
        alert('Le password nuove non corrispondono');
        valido = false;
    }

    if (valido) {
        document.getElementById('credenzialiForm').submit();
    }
}


function confermaCambioPreferito() {
    return confirm("Sei sicuro di voler cambiare l'indirizzo preferito?");
}




