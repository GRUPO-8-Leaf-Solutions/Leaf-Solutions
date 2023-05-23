var database = require("../database/config")

function listar() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar()");
    var instrucao = `
        SELECT * FROM estufa;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function qtdSetores(idUsuario) {
var instrucao = `
select count(IdSetor) as totalSetores
from empresa 
join estufa on empresa.idEmpresa = estufa.fkEmpresa
join setor on estufa.idEstufa = setor.fkEstufa
where idEmpresa = ${idUsuario}
group by idEstufa;`;
    return database.executar(instrucao);
}

module.exports = {
listar,
qtdSetores
}