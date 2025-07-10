<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Registrazione - BeeNatural</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">
</head>
<body>
<div class="centered">
    <img src="${pageContext.request.contextPath}/images/loghi/Logo.jpeg" alt="Logo BeeNatural" width="100">
    <h2>Crea un nuovo account</h2>

    <form method="post" action="${pageContext.request.contextPath}/register" onsubmit="return validateForm()">
        <label for="nome">Nome:</label>
        <input type="text" id="nome" name="nome" required pattern=".{2,}" title="Minimo 2 caratteri">
        <div id="nomeError" class="error-msg"></div>

        <label for="cognome">Cognome:</label>
        <input type="text" id="cognome" name="cognome" required pattern=".{2,}" title="Minimo 2 caratteri">
        <div id="cognomeError" class="error-msg"></div>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        <div id="emailError" class="error-msg"></div>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required pattern=".{8,}" title="Almeno 8 caratteri">
        <div id="passwordError" class="error-msg"></div>

        <label for="confermaPassword">Conferma Password:</label>
        <input type="password" id="confermaPassword" name="confermaPassword" required>
        <div id="confermaPasswordError" class="error-msg"></div>

        <label for="indirizzo">Indirizzo:</label>
        <input type="text" id="indirizzo" name="indirizzo" required>
        <div id="indirizzoError" class="error-msg"></div>

        <label for="telefono">Telefono:</label>
        <input type="tel" id="telefono" name="telefono" pattern="\d{9,15}" title="Inserisci solo numeri (9-15 cifre)" required>
        <div id="telefonoError" class="error-msg"></div>

        <button type="submit">Registrati</button>
    </form>

    <div class="messaggio errore">
        <%= request.getAttribute("errore") != null ? request.getAttribute("errore") : "" %>
    </div>
    <div class="messaggio successo">
        <%= request.getAttribute("successo") != null ? request.getAttribute("successo") : "" %>
    </div>
</div>

<script>
    const fields = ['nome', 'cognome', 'email', 'password', 'confermaPassword', 'indirizzo', 'telefono'];

    fields.forEach(id => {
        document.getElementById(id).addEventListener('input', () => validateField(id));
    });

    function validateField(id) {
        const input = document.getElementById(id);
        const errorDiv = document.getElementById(id + 'Error');

        if (input.validity.valid) {
            input.classList.remove('invalid');
            input.classList.add('valid');
            errorDiv.textContent = '';
        } else {
            input.classList.remove('valid');
            input.classList.add('invalid');
            errorDiv.textContent = input.title;
        }

        if (id === 'confermaPassword') {
            const pwd = document.getElementById('password');
            if (input.value !== pwd.value) {
                input.classList.add('invalid');
                errorDiv.textContent = 'Le password non coincidono';
            }
        }
    }

    function validateForm() {
        let valid = true;
        fields.forEach(id => {
            validateField(id);
            if (!document.getElementById(id).checkValidity()) valid = false;
        });

        const pwd = document.getElementById('password').value;
        const confirm = document.getElementById('confermaPassword').value;
        if (pwd !== confirm) {
            document.getElementById('confermaPasswordError').textContent = 'Le password non coincidono';
            valid = false;
        }
        return valid;
    }
</script>
</body>
</html>