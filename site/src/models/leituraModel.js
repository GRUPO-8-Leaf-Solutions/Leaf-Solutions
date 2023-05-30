var database = require("../database/config")


function obterMenorIndice(idEmpresa) {
    var instrucao = `
    SELECT MIN(leituraSensor.valor) AS valor_minimo,
    estufa.nome AS nome_estufa,
    setor.idSetor,
    sensor.idSensor,
    leituraSensor.leituraTime AS horaLeitura
    FROM leituraSensor
    JOIN sensor ON leituraSensor.fkSensor = sensor.idSensor
    JOIN subsetor ON sensor.fkSubSetor = subsetor.idSubSetor
    JOIN setor ON subsetor.fkSetor = setor.idSetor
    JOIN estufa ON setor.fkEstufa = estufa.idEstufa
    JOIN empresa ON estufa.fkEmpresa = empresa.idEmpresa
    WHERE empresa.idEmpresa = ${idEmpresa} AND leituraSensor.leituraDate = CURDATE()
    GROUP BY estufa.nome, setor.idSetor, sensor.idSensor, leituraSensor.leituraTime
    ORDER BY valor_minimo 
    LIMIT 1;
    `
    return database.executar(instrucao)
}

function obterMaiorIndice(idEmpresa) {
    var instrucao = `
    SELECT MAX(leituraSensor.valor) AS valor_maximo,
    estufa.nome AS nome_estufa,
    setor.idSetor,
    sensor.idSensor,
    leituraSensor.leituraTime AS horaLeitura
    FROM leituraSensor
    JOIN sensor ON leituraSensor.fkSensor = sensor.idSensor
    JOIN subsetor ON sensor.fkSubSetor = subsetor.idSubSetor
    JOIN setor ON subsetor.fkSetor = setor.idSetor
    JOIN estufa ON setor.fkEstufa = estufa.idEstufa
    JOIN empresa ON estufa.fkEmpresa = empresa.idEmpresa
    WHERE empresa.idEmpresa = ${idEmpresa} AND leituraSensor.leituraDate = CURDATE()
    GROUP BY estufa.nome, setor.idSetor, sensor.idSensor, leituraSensor.leituraTime
    ORDER BY valor_maximo DESC
    LIMIT 1;
    `
    return database.executar(instrucao)
}

function buscarUltimasMedidas(idEmpresa) {

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = ``;
    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
          var instrucaoSql = `SELECT estufa.nome AS 'nome_estufa', ROUND(AVG(leituraSensor.valor),0) AS 'media_Valor', leituraSensor.leituraTime
          FROM empresa
          LEFT JOIN estufa ON empresa.idEmpresa = estufa.fkEmpresa
          LEFT JOIN setor ON estufa.idEstufa = setor.fkEstufa
          LEFT JOIN subSetor ON setor.idSetor = subSetor.fkSetor
          LEFT JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
          LEFT JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor WHERE idEmpresa = ${idEmpresa} && leituraDate = curDate()
          GROUP BY empresa.idEmpresa, estufa.nome, leituraSensor.leituraTime;`
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function tempoReal(idEmpresa) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = ``;

    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `SELECT estufa.nome AS 'nome estufa', ROUND(AVG(leituraSensor.valor),0) AS 'media Valor'
        FROM empresa
        LEFT JOIN estufa ON empresa.idEmpresa = estufa.fkEmpresa
        LEFT JOIN setor ON estufa.idEstufa = setor.fkEstufa
        LEFT JOIN subSetor ON setor.idSetor = subSetor.fkSetor
        LEFT JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
        LEFT JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor WHERE idEmpresa = ${idEmpresa}
        GROUP BY empresa.idEmpresa, estufa.nome;`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function obterCaptacoes(idEmpresa) {
    var instrucao = `SELECT
    estufa.nome AS nomeEstufa,
    setor.idSetor,
    subSetor.idSubSetor,
    leituraSensor.valor AS indiceAtual,
    leituraTime as horarioLeitura
        FROM estufa JOIN setor 
        ON estufa.idEstufa = setor.fkEstufa
        JOIN subSetor 
        ON setor.idSetor = subSetor.fkSetor
        JOIN sensor 
        ON subSetor.idSubSetor = sensor.fkSubSetor
        JOIN leituraSensor 
        ON sensor.idSensor = leituraSensor.fkSensor
           WHERE fkEmpresa = ${idEmpresa} && leituraDate = curDate()`

    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function obterSituacao(idEmpresa){
    var instrucao = `
    select 
	count(a.Alerta)
    from(
			select
			estufa.nome Estufa,
			fkAlerta Alerta,
			count(fkAlerta) qtde
			from estufa 
			join setor on idEstufa = fkEstufa 
			join subSetor on idSetor = fkSetor 
			join sensor on idSubSetor = fkSubSetor
			join leituraSensor on idSensor = fkSensor
			group by estufa.nome, fkAlerta) as a 
            group by Alerta;
    `
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

module.exports = {
    buscarUltimasMedidas,
    tempoReal,
    obterCaptacoes,
    obterMenorIndice,
    obterMaiorIndice,
    obterSituacao
};