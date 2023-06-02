var database = require("../database/config")


function listar() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar()");
    var instrucao = `
        SELECT * FROM estufa;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
};

function buscarSubSetor(idSubSetor) {
    var instrucao = `
    select idSensor Sensor from subSetor join sensor on idSubSetor = fkSubSetor where idSubSetor = ${idSubSetor};
    `
    return database.executar(instrucao)
};

function buscarSensor(idSubSetor) {
    var instrucao = `
   select idSensor Sensor from subSetor join sensor on idSubSetor = fkSubSetor where idSubSetor = ${idSubSetor};
    `
    return database.executar(instrucao)
};

function menorCaptacao(idEmpresa, idSensor, idSubSetor, id) {
    var instrucao = `SELECT Min(leituraSensor.valor) AS valor_minimo,
    leituraSensor.leituraTime AS horaLeitura
    FROM leituraSensor
    JOIN sensor ON leituraSensor.fkSensor = sensor.idSensor
    JOIN subsetor ON sensor.fkSubSetor = subsetor.idSubSetor
    JOIN setor ON subsetor.fkSetor = setor.idSetor
    JOIN estufa ON setor.fkEstufa = estufa.idEstufa
    JOIN empresa ON estufa.fkEmpresa = empresa.idEmpresa
    WHERE empresa.idEmpresa = ${idEmpresa} AND leituraSensor.leituraDate = CURDATE() AND sensor.idSensor = ${idSensor} AND subsetor.idSubsetor = ${idSubSetor} AND estufa.idEstufa = ${id}
    GROUP BY estufa.nome, setor.idSetor, sensor.idSensor, leituraSensor.leituraTime, subSetor.idSubsetor
    ORDER BY valor_minimo;`
    return database.executar(instrucao)
}
//  function maiorCaptacao(idSensor){

//  }
module.exports = {
    buscarSubSetor,
    buscarSensor,
    menorCaptacao,
    // maiorCaptacao
};
