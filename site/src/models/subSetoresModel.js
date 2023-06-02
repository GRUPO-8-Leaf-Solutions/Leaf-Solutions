var database = require("../database/config")


function listar() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar()");
    var instrucao = `
        SELECT * FROM estufa;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
};

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
    buscarSubSetor,
    buscarSensor,
};
