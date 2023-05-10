// sessão
function validarSessao() {
    // aguardar();

    var email = sessionStorage.EMAIL_USUARIO;
    var nome = sessionStorage.NOME_USUARIO;

    var b_usuario = document.getElementById("b_usuario");

    if (email != null && nome != null) {
        // window.alert(`Seja bem-vindo, ${nome}!`);
        b_usuario.innerHTML = nome;

        // finalizarAguardar();
    } else {
        window.location = "../login.html";
    }
}

function limparSessao() {
    // aguardar();
    sessionStorage.clear();
    // finalizarAguardar();
    window.location = "../login.html";
}

// carregamento (loading)
function aguardar() {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "flex";
}

function finalizarAguardar(texto) {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "none";

    var divErrosLogin = document.getElementById("div_erros_login");
    if (texto) {
        divErrosLogin.style.display = "flex";
        divErrosLogin.innerHTML = texto;
    }
}


// modal
function mostrarModal() {
    var divModal = document.getElementById("div_modal");
    divModal.style.display = "flex";
}

function fecharModal() {
    var divModal = document.getElementById("div_modal");
    divModal.style.display = "none";
}


// teste
function simuladorFinanceiro() {
    var qtdMetros = Number(ipt_qtdM.value);
    var qtdPes = Number(ipt_qtdPes.value);
    var valorUnid = Number(ipt_valorUnid.value);
    var qtdFolhas = Number(ipt_qtdFolhas.value);
    var pesoUnid = Number(ipt_pesoUnid.value);
    var totalVenda = (qtdPes * qtdMetros) * valorUnid;
    var totalSolucao = (totalVenda * 1.50);
    var aumentoFolha = (qtdFolhas * 1.47);
    var aumentoPeso = (pesoUnid * 1.57);
    var aumentoVenda = (valorUnid * 1.40);

    if (qtdMetros == 0 && qtdPes == 0 && valorUnid == 0 && qtdFolhas == 0 && pesoUnid == 0) {

    } else {
        resultadoSimulador.innerHTML = `
        <div id="divSimulador">
        <span style="text-align:center; font-size: 40px;">Sem a nossa solução</span>
        <ul>
            <li>
                R$${totalVenda}
            </li>
            <li>
                ${qtdFolhas}
            </li>
            <li>
                ${pesoUnid}g
            </li>
        </div>

        <div id="divSimulador">
        <span style="text-align:center; font-size: 45px; font-weight: 600;">Com a nossa solução!</span>
        <ul>
            <li style="font-weight: 600;">
                R$${totalSolucao} <span style="color: Lime; font-size: 20px">(+50%)</span>
            </li>
            <li style="font-weight: 600;">
                 ${aumentoFolha} <span style="color: Lime; font-size: 20px">(+47%)</span>
            </li>
            <li style="font-weight: 600;">
                ${aumentoPeso}g <span style="color: Lime; font-size: 20px">(+57%)</span>
            </li>
        </div>

            `
    }
}

function aguardar() {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "flex";
}


function finalizarAguardar(texto) {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "none";

    var divErrosLogin = document.getElementById("div_erros_login");
    if (texto) {
        divErrosLogin.style.display = "flex";
        divErrosLogin.innerHTML = texto;
    }
}
