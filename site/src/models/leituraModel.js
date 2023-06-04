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
          ORDER BY ultima_leitura desc limit ${limiteLinhas * 5} ;
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
        SELECT estufa.nome AS 'nome_estufa', COALESCE(ROUND(AVG(leituraSensor.valor), 0), 0) AS 'media_valor', MAX(leituraSensor.leituraTime) AS 'ultima_leitura'
        FROM estufa
        LEFT JOIN setor ON estufa.idEstufa = setor.fkEstufa
        LEFT JOIN subSetor ON setor.idSetor = subSetor.fkSetor
        LEFT JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
        JOIN (
            SELECT fkSensor, MAX(leituraTime) AS ultima_leitura
            FROM leituraSensor
            GROUP BY fkSensor
        ) AS ultimaLeitura ON sensor.idSensor = ultimaLeitura.fkSensor 
        LEFT JOIN leituraSensor ON ultimaLeitura.fkSensor = leituraSensor.fkSensor AND ultimaLeitura.ultima_leitura = leituraSensor.leituraTime
        where fkEmpresa = ${idEmpresa}
        GROUP BY estufa.idEstufa, estufa.nome
        ORDER BY ultima_leitura DESC;
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
    leituraSensor.fkAlerta,
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
    WHERE estufa.fkEmpresa = ${idEmpresa} and leituraSensor.leituraDate = curDate();`

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
    alerta.idAlerta,
    count(estufa.idEstufa) as qtdEstufas
from alerta
    left join (
        select
            estufa.idEstufa,
            leituraSensor.fkAlerta,
            leituraSensor.leituraTime,
            row_number() over (partition by estufa.idEstufa order by leituraTime desc) as rowNum
        from leituraSensor
            left join sensor on sensor.idSensor = leituraSensor.fkSensor
            left join subSetor on subSetor.idSubSetor = sensor.fkSubSetor
            left join setor on setor.idSetor = subSetor.fkSetor
            left join estufa on estufa.idEstufa = setor.fkEstufa
        where
        estufa.fkEmpresa = ${idEmpresa}
    ) as leituraSensor on alerta.idAlerta = leituraSensor.fkAlerta
    left join estufa on estufa.idEstufa = leituraSensor.idEstufa
    where leituraSensor.rowNum = 1
    group by alerta.idAlerta
    order by qtdEstufas desc;
    `


   
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

// figma
// acho que sim, tava com medo de descomentar e afetar a tela enquanto vcs tavam mexendo

module.exports = {
    buscarUltimasMedidas,
    tempoReal,
    obterUltimasCapturasAlertas,
    obterMenorIndice,
    obterMaiorIndice,
    obterSituacao
};
 
