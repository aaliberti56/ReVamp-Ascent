// Inizializzazione validazione login e modifica credenziali
document.addEventListener("DOMContentLoaded", () => {
    inizializzaLoginForm();
    inizializzaFormModificaCredenziali();
    aggiornaListaMetodiPagamento();
});

// === VALIDAZIONE FORM LOGIN ===
function inizializzaLoginForm() {
    const form = document.getElementById('formLogin');
    if (form) {
        form.addEventListener("submit", function (event) {
            if (!validazioneCampiLogin()) {
                event.preventDefault();
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
function validazioneModificaCredenziali() {
    const username = document.getElementById('username').value.trim();
    const oldpass = document.getElementById('oldpass').value.trim();
    const newpass = document.getElementById('newpass').value.trim();
    const confpass = document.getElementById('confpass').value.trim();

    if (username === '') {
        alert('Username non può essere vuoto');
        return false;
    }
    if (oldpass === '') {
        alert('Inserisci la password attuale');
        return false;
    }

    // Se l'utente ha inserito una nuova password, allora validiamola
    if (newpass !== '') {
        if (newpass.length < 3 || !(/[a-zA-Z]/.test(newpass)) || !(/\d/.test(newpass))) {
            alert('La password deve contenere almeno 3 caratteri, inclusa almeno una lettera e un numero');
            return false;
        }
        if (newpass !== confpass) {
            alert('Le password nuove non corrispondono');
            return false;
        }
    }

    return true;
}



// === CHIUSURA MESSAGGIO SERVER ===
function nascondiMessaggio() {
    const container = document.querySelector('.containerMessaggio');
    if (container) {
        container.style.display = 'none';
    }
}

function confermaCambioPreferito() {
    return confirm("Sei sicuro di voler cambiare l'indirizzo preferito?");
}









