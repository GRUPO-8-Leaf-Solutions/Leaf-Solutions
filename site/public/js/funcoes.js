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
            <span>
                Sem a <b style="color: Lime">nossa</b> solução, você teve um faturamento total de <b style="color: red">R$ ${totalVenda}</b> com as vendas dos pés de alface no último mês. 
            </span>

            <span> 
                <b style="color: lime">Com a nossa solução</b>, seu faturamento aumentaria em <b style="color: lightblue">50%</b>, totalizando <b style="color: yellow">R$${totalSolucao}</b> com as vendas dos pés de alface no ultimo mês!
            </span>

            <span>
                Além de <b style="color: lime">aumentar</b> em até <b style="color: lightblue">47%</b> do número de folhas de cada pé, totalizando  <b style="color: yellow">${aumentoFolha}</b> folhas e  <b style="color:lightblue">57%</b> do peso de cada pé, totalizando <b style="color: yellow">${aumentoPeso}g</b>.
            </span>
            
            <span>
                Com uma melhoria na qualidade da alface, sugerimos um aumento no valor de venda do produto em até <b style="color: lightblue">40%</b>, totalizando <b style="color: yellow">R$${aumentoVenda}</b> por unidade.
            </span>    
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
