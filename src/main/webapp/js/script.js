function validate() {
    const email = document.getElementById("email").value;
    const pass = document.getElementById("password").value;
    const pass2 = document.getElementById("password2").value;

    const emailOk = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    const passOk = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9]).{3,}$/.test(pass);

    document.getElementById("errorMail").style.display = emailOk ? "none" : "inline";
    document.getElementById("errorPass").style.display = passOk ? "none" : "inline";
    document.getElementById("errorPass2").style.display = pass === pass2 ? "none" : "inline";

    if (emailOk && passOk && pass === pass2) {
        document.getElementById("form").submit();
    }
}
