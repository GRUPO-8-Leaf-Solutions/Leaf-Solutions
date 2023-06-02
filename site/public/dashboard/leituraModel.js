var database = require("../database/config")


function obterMenorIndice(idEmpresa) {
    var instrucao = `
    SELECT MIN(leituraSensor.valor) AS valor_minimo,
    estufa.nome AS nome_estufa,
    setor.idSetor,
    subSetor.idSubsetor,
    sensor.idSensor,
    leituraSensor.leituraTime AS horaLeitura
    FROM leituraSensor
    JOIN sensor ON leituraSensor.fkSensor = sensor.idSensor
    JOIN subSetor ON sensor.fkSubSetor = subSetor.idSubSetor
    JOIN setor ON subSetor.fkSetor = setor.idSetor
    JOIN estufa ON setor.fkEstufa = estufa.idEstufa
    JOIN empresa ON estufa.fkEmpresa = empresa.idEmpresa
    WHERE empresa.idEmpresa = ${idEmpresa} AND leituraSensor.leituraDate = CURDATE()
    GROUP BY estufa.nome, setor.idSetor, sensor.idSensor, leituraSensor.leituraTime, subSetor.idSubsetor
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
    subSetor.idSubsetor,
    sensor.idSensor,
    leituraSensor.leituraTime AS horaLeitura
    FROM leituraSensor
    JOIN sensor ON leituraSensor.fkSensor = sensor.idSensor
    JOIN subSetor ON sensor.fkSubSetor = subSetor.idSubSetor
    JOIN setor ON subSetor.fkSetor = setor.idSetor
    JOIN estufa ON setor.fkEstufa = estufa.idEstufa
    JOIN empresa ON estufa.fkEmpresa = empresa.idEmpresa
    WHERE empresa.idEmpresa = ${idEmpresa} AND leituraSensor.leituraDate = CURDATE()
    GROUP BY estufa.nome, setor.idSetor, sensor.idSensor, leituraSensor.leituraTime, subSetor.idSubsetor
    ORDER BY valor_maximo DESC
    LIMIT 1;
    `
    return database.executar(instrucao)
}

function buscarUltimasMedidas(idEmpresa) {

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = ``;
    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
          var instrucaoSql = `
          SELECT estufa.nome AS 'nome_estufa', COALESCE(ROUND(AVG(leituraSensor.valor), 0), 0) AS 'media_Valor', leituraSensor.leituraTime AS 'ultima_leitura'
          FROM estufa
          LEFT JOIN setor ON estufa.idEstufa = setor.fkEstufa
          LEFT JOIN subSetor ON setor.idSetor = subSetor.fkSetor
          LEFT JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
          LEFT JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor 
          WHERE estufa.fkEmpresa = 1
          GROUP BY estufa.idEstufa, estufa.nome, leituraSensor.leituraTime
          ORDER BY ultima_leitura DESC;
          `
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function tempoReal(idEmpresa) {

    var instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = ``;

    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        var instrucaoSql = `
        SELECT estufa.nome AS 'nome_estufa', COALESCE(ROUND(AVG(leituraSensor.valor), 0), 0) AS 'media_Valor', MAX(leituraSensor.leituraTime) AS 'leituraTime'
        FROM estufa
        LEFT JOIN setor ON estufa.idEstufa = setor.fkEstufa
        LEFT JOIN subSetor ON setor.idSetor = subSetor.fkSetor
        LEFT JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
        LEFT JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor AND DATE(leituraSensor.leituraDate) = CURDATE()
        WHERE estufa.fkEmpresa = ${idEmpresa}
        GROUP BY estufa.idEstufa, estufa.nome
        ORDER BY leituraTime DESC;
        `
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
            where fkEmpresa = ${idEmpresa} && leituraDate = curDate()
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