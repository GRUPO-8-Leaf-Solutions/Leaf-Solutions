var database = require("../database/config")

function listar() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar()");
    var instrucao = `
        SELECT * FROM estufa;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function obterSetores(idUsuarioServer){
    var instrucao = `
    SELECT * FROM setor join estufa on fkEstufa = idEstufa
					join empresa on fkEmpresa = idEmpresa
						where idEmpresa = ${idUsuarioServer};
    `
    return database.executar(instrucao);
}

function exibirQtdSetores(idUsuarioServer) {
    var instrucao = `SELECT count(idSetor) as totalSetores 
    from empresa
    left join estufa on empresa.idEmpresa = estufa.fkEmpresa
    left join setor on estufa.idEstufa = setor.fkEstufa
    where idEmpresa = ${idUsuarioServer}
    group by idEstufa;
    `;
    return database.executar(instrucao);
}

function buscarSubSetor(idSubSetorServer) {
    var instrucao = `
    select idSubSetor Subsetor from setor join subSetor on idSetor = fkSetor where idSetor = ${idSubSetorServer};
    `
    return database.executar(instrucao)
};

function buscarSensor(idSubSetorServer) {
    var instrucao = `
   select idSensor Sensor from subSetor join sensor on idSubSetor = fkSubSetor where idSubSetor = ${idSubSetorServer};
    `
    return database.executar(instrucao)
};


module.exports = {
listar,
exibirQtdSetores,
obterSetores,
buscarSubSetor,
buscarSensor
}