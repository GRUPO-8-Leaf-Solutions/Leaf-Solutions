var database = require("../database/config")


function coletarMaiorIndice() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar()");
    var instrucao = `
        SELECT * FROM estufa;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function coletarMenorIndice(idEmpresa) {
    var instrucao = `
    SELECT * FROM estufa JOIN empresa ON fkEmpresa = idEmpresa WHERE idEmrpesa = ${idEmpresa}
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}



module.exports = {
    coletarMaiorIndice,
    coletarMenorIndice
};