var database = require("../database/config")


function listar() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar()");
    var instrucao = `
        SELECT * FROM estufa;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
};

function buscarSubSetor(idSetor) {
    var instrucao = `
    select idSubSetor subSetor from subSetor join setor on idSetor = fkSetor where idSetor = ${idSetor};
    `
    return database.executar(instrucao)
};

function buscarSensor(idSubSetor) {
    var instrucao = `
   select idSensor Sensor from subSetor join sensor on idSubSetor = fkSubSetor where idSubSetor = ${idSubSetor};
    `
    return database.executar(instrucao)
};

function obterMenorIndice(idEmpresa, idSensor, idSubSetor, idEstufa, idSetor) {
    var instrucao = `SELECT Min(leituraSensor.valor) AS valor_minimo,
    leituraSensor.leituraTime AS horaLeitura
    FROM leituraSensor
    JOIN sensor ON leituraSensor.fkSensor = sensor.idSensor
    JOIN subsetor ON sensor.fkSubSetor = subsetor.idSubSetor
    JOIN setor ON subsetor.fkSetor = setor.idSetor
    JOIN estufa ON setor.fkEstufa = estufa.idEstufa
    JOIN empresa ON estufa.fkEmpresa = empresa.idEmpresa
    WHERE empresa.idEmpresa = ${idEmpresa} AND leituraSensor.leituraDate = CURDATE() AND sensor.idSensor = ${idSensor} AND subsetor.idSubsetor = ${idSubSetor} AND estufa.idEstufa = ${idEstufa} AND setor.idSetor = ${idSetor}
    GROUP BY estufa.nome, setor.idSetor, sensor.idSensor, leituraSensor.leituraTime, subSetor.idSubsetor
    ORDER BY valor_minimo;`
    return database.executar(instrucao)
}

function obterMaiorIndice(idEmpresa, idSensor, idSubSetor, idEstufa, idSetor) {
    var instrucao = `SELECT Max(leituraSensor.valor) AS valor_maximo,
    leituraSensor.leituraTime AS horaLeitura
    FROM leituraSensor
    JOIN sensor ON leituraSensor.fkSensor = sensor.idSensor
    JOIN subsetor ON sensor.fkSubSetor = subsetor.idSubSetor
    JOIN setor ON subsetor.fkSetor = setor.idSetor
    JOIN estufa ON setor.fkEstufa = estufa.idEstufa
    JOIN empresa ON estufa.fkEmpresa = empresa.idEmpresa
        WHERE empresa.idEmpresa = ${idEmpresa} AND leituraSensor.leituraDate = CURDATE() AND sensor.idSensor = ${idSensor} AND subsetor.idSubsetor = ${idSubSetor} AND estufa.idEstufa = ${idEstufa} AND setor.idSetor = ${idSetor}
    GROUP BY estufa.nome, setor.idSetor, sensor.idSensor, leituraSensor.leituraTime, subSetor.idSubsetor
    ORDER BY valor_maximo desc;`
    return database.executar(instrucao)
}

function obterIndiceAtual(idEmpresa, idEstufa, idSetor, idSubSetor, idSensor) {
    var instrucao = `
    SELECT
leituraSensor.leituraTime as 'hora',
leituraSensor.valor as 'valorAtual'
FROM empresa JOIN estufa ON empresa.idEmpresa = estufa.fkEmpresa
JOIN setor ON estufa.idEstufa = setor.fkEstufa
JOIN subSetor ON setor.idSetor = subSetor.fkSetor
JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor
WHERE empresa.idEmpresa = ${idEmpresa}
AND
estufa.idEstufa = ${idEstufa}
AND
setor.idSetor = ${idSetor}
AND
subSetor.idSubSetor = ${idSubSetor}
AND
sensor.idSensor = ${idSensor}
order by leituraSensor.leituraTime DESC
;
    `
    return database.executar(instrucao)
}


module.exports = {
    buscarSubSetor,
    buscarSensor,
    obterMenorIndice,
    obterMaiorIndice,
    obterIndiceAtual
};
