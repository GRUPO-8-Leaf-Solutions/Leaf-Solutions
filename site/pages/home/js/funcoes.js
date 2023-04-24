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
        <h3 style="text-align:center">Sem a nossa solução:</h3>
        <ul>
            <li>
                Faturamento total: ${totalVenda}
            </li>
            <li>
                Número de folhas por unidade: ${qtdFolhas}
            </li>
            <li>
                Peso por unidade: ${pesoUnid}
            </li>
        </div>

        <div id="divSimulador">
        <h3 style="text-align:center">Com a Leaf Solutions:</h3>
        <ul>
            <li>
                Faturamento total: ${totalSolucao} <spam style="color: Lime">(+50%)</spam>
            </li>
            <li>
                Número de folhas por unidade: ${aumentoFolha} <spam style="color: Lime">(+47%)</spam>
            </li>
            <li>
                Peso por unidade: ${aumentoPeso} <spam style="color: Lime">(+57%)</spam>
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
