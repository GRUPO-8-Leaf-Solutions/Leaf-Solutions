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
    JOIN subsetor ON sensor.fkSubSetor = subsetor.idSubSetor
    JOIN setor ON subsetor.fkSetor = setor.idSetor
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
    JOIN subsetor ON sensor.fkSubSetor = subsetor.idSubSetor
    JOIN setor ON subsetor.fkSetor = setor.idSetor
    JOIN estufa ON setor.fkEstufa = estufa.idEstufa
    JOIN empresa ON estufa.fkEmpresa = empresa.idEmpresa
    WHERE empresa.idEmpresa = ${idEmpresa} AND leituraSensor.leituraDate = CURDATE()
    GROUP BY estufa.nome, setor.idSetor, sensor.idSensor, leituraSensor.leituraTime, subSetor.idSubsetor
    ORDER BY valor_maximo DESC
    LIMIT 1;
    `
    return database.executar(instrucao)
}

function buscarUltimasMedidas(idEmpresa, limiteLinhas) {

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = ``;
    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        var instrucaoSql = `
          SELECT estufa.nome AS 'nome_estufa', COALESCE(ROUND(AVG(leituraSensor.valor), 0), 0) AS 'media_Valor', leituraSensor.leituraTime AS 'ultima_leitura'
          FROM estufa
          JOIN setor ON estufa.idEstufa = setor.fkEstufa
          JOIN subSetor ON setor.idSetor = subSetor.fkSetor
          JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
          JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor AND DATE(leituraSensor.leituraDate) = CURDATE()
          WHERE estufa.fkEmpresa = ${idEmpresa}
          GROUP BY estufa.idEstufa, estufa.nome, leituraSensor.leituraTime
          ORDER BY ultima_leitura DESC limit ${limiteLinhas * 5};
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
        select estufa.nome as 'nome_estufa', coalesce(round(avg(leituraSensor.valor), 0), 0) as "media_valor", leituraSensor.leituraTime
        from empresa
        left join estufa on estufa.fkEmpresa = empresa.idEmpresa
        left join setor on setor.fkEstufa = estufa.idEstufa
        left join subSetor on subSetor.fkSetor = setor.idSetor
        left join sensor on sensor.fkSubSetor = subSetor.idSubSetor
        join(select fkSensor, max(leituraTime) as ultima_leitura
            from leituraSensor
            group by fkSensor
        ) as ultimaLeitura ON sensor.idSensor = ultimaLeitura.fkSensor 
        left join leituraSensor on ultimaLeitura.fkSensor AND ultimaLeitura.ultima_leitura = leituraSensor.leituraTime
        where idEmpresa = ${idEmpresa}
        group by estufa.idEstufa, estufa.nome, leituraSensor.leituraTime
        order by leituraSensor.leituraTime DESC;
            ;
        `
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function obterUltimasCapturasAlertas(idEmpresa) {

    var instrucao = `SELECT
    estufa.nome AS nomeEstufa,
    setor.idSetor,
    subSetor.idSubSetor,
    sensor.idSensor,
    leituraSensor.valor AS indiceAtual,
    leituraSensor.leituraTime AS horarioLeitura
    FROM estufa
    JOIN setor ON estufa.idEstufa = setor.fkEstufa
    JOIN subSetor ON setor.idSetor = subSetor.fkSetor
    JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
    JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor
    JOIN (
        SELECT
            fkSensor,
            MAX(leituraTime) AS ultimaLeitura
        FROM leituraSensor
        GROUP BY fkSensor) ultimaLeitura ON leituraSensor.fkSensor = ultimaLeitura.fkSensor && leituraSensor.leituraTime = ultimaLeitura.ultimaLeitura
    WHERE estufa.fkEmpresa = ${idEmpresa};`

    // var instrucao = `SELECT
    // estufa.nome AS nomeEstufa,
    // setor.idSetor,
    // subSetor.idSubSetor,
    // leituraSensor.valor AS indiceAtual,
    // leituraTime as horarioLeitura
    //     FROM estufa JOIN setor 
    //     ON estufa.idEstufa = setor.fkEstufa
    //     JOIN subSetor 
    //     ON setor.idSetor = subSetor.fkSetor
    //     JOIN sensor 
    //     ON subSetor.idSubSetor = sensor.fkSubSetor
    //     JOIN leituraSensor 
    //     ON sensor.idSensor = leituraSensor.fkSensor
    //        WHERE fkEmpresa = ${idEmpresa} && leituraDate = curDate();`

    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function obterSituacao(idEmpresa) {
    var instrucao = `
    select
		count(a.Alerta)
		from(
	select estufa.nome, max(fkAlerta) as Alerta, max(leituraSensor.leituraTime) as ultimaLeitura, count(fkAlerta) qtde
        from estufa
		left join setor on idEstufa = fkEstufa 
		left join subSetor on idSetor = fkSetor 
		left join sensor on idSubSetor = fkSubSetor
        left join (select fkSensor, max(leituraTime) as ultima_leitura
            from leituraSensor
            group by fkSensor
        ) as ultimaLeitura on sensor.idSensor = ultimaLeitura.fkSensor 
         left join leituraSensor on ultimaLeitura.fkSensor = leituraSensor.fkSensor and ultimaLeitura.ultima_leitura = leituraSensor.leituraTime
        where fkEmpresa = ${idEmpresa}
        group by estufa.nome
        order by ultimaLeitura desc) as a
         group by Alerta;
    `
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

module.exports = {
    buscarUltimasMedidas,
    tempoReal,
    obterUltimasCapturasAlertas,
    obterMenorIndice,
    obterMaiorIndice,
    obterSituacao
};

