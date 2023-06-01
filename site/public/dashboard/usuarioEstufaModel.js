var database = require("../database/config")

function cadastrarEstufa(nome, area) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrarEstufa():",nome, area);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.

    // informações de acordo com a tabela endereço do banco de dados  
    var instrucao = `
        INSERT INTO estufa (nome, area, fkEmpresa, fkEndereco) VALUES ('${nome}', '${area}', 1, 1);
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function listar() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar()");
    var instrucao = `
        SELECT * FROM estufa;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function exibirEstufas(idUsuarioServer) {
    console.log("function da model", idUsuarioServer)
    var instrucao = `SELECT * FROM estufa join empresa on fkEmpresa = idEmpresa where idEmpresa = ${idUsuarioServer};`;
    return database.executar(instrucao);
}

function rankMaisAlertas(idUsuarioServer){
    var instrucao = `
    SELECT COUNT(leituraSensor.idLeituraSensor) AS total_leituras, estufa.nome AS nome_estufa
FROM leituraSensor
LEFT JOIN sensor ON leituraSensor.fkSensor = sensor.idSensor
LEFT JOIN subSetor ON sensor.fkSubSetor = subSetor.idSubSetor
LEFT JOIN setor ON subSetor.fkSetor = setor.idSetor
LEFT JOIN estufa ON setor.fkEstufa = estufa.idEstufa
LEFT JOIN empresa ON estufa.fkEmpresa = empresa.idEmpresa
WHERE leituraSensor.leituraDate = CURDATE() AND empresa.idEmpresa = ${idUsuarioServer} AND (leituraSensor.valor < 500 OR leituraSensor.valor > 600)
GROUP BY estufa.nome
ORDER BY COUNT(leituraSensor.idLeituraSensor) DESC
limit 3 ;
    `
    return database.executar(instrucao)
}

module.exports = {
    cadastrarEstufa,
    listar,
    exibirEstufas,
    rankMaisAlertas
};