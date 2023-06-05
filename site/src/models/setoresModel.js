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
    var instrucao = `SELECT count(idSetor) as totalSetores, empresa.razaoSocial as nome
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

function estadosSetores(idEmpresa){
    var instrucao = `
    SELECT s.idSetor, a.tipo AS estado, COUNT(*) AS quantidade
    FROM estufa e
        join empresa ON e.fkEmpresa = empresa.idEmpresa
        JOIN setor s ON s.fkEstufa = e.idEstufa
        JOIN subSetor ss ON ss.fkSetor = s.idSetor
        JOIN sensor se ON se.fkSubSetor = ss.idSubSetor
        JOIN leituraSensor ls ON ls.fkSensor = se.idSensor
    JOIN (
        SELECT MAX(idLeituraSensor) AS ultima_leitura, fkSensor
        FROM leituraSensor
        GROUP BY fkSensor
    ) ul ON ul.fkSensor = ls.fkSensor AND ul.ultima_leitura = ls.idLeituraSensor
    JOIN alerta a ON a.idAlerta = ls.fkAlerta
    where empresa.idEmpresa = ${idEmpresa} and ls.leituraDate = curdate()
    GROUP BY s.idSetor, a.tipo
    ORDER BY s.idSetor;
    `

    return database.executar(instrucao)
}

function pegarNome(idEmpresa) {
    var instrucao = `
    SELECT COUNT(leituraSensor.idLeituraSensor) AS total_leituras, estufa.nome AS nome
    FROM leituraSensor
    LEFT JOIN sensor ON leituraSensor.fkSensor = sensor.idSensor
    LEFT JOIN subsetor ON sensor.fkSubSetor = subsetor.idSubSetor
    LEFT JOIN setor ON subsetor.fkSetor = setor.idSetor
    LEFT JOIN estufa ON setor.fkEstufa = estufa.idEstufa
    LEFT JOIN empresa ON estufa.fkEmpresa = empresa.idEmpresa
    WHERE leituraSensor.leituraDate = CURDATE() AND empresa.idEmpresa = ${idUsuarioServer} AND (leituraSensor.valor < 500 OR leituraSensor.valor > 600)
    GROUP BY estufa.nome
    ORDER BY COUNT(leituraSensor.idLeituraSensor) DESC
    limit 3 ;
      `;
  
    return database.executar(instrucao);
  }

module.exports = {
listar,
exibirQtdSetores,
obterSetores,
buscarSubSetor,
buscarSensor,
estadosSetores,
pegarNome
}