var database = require("../database/config");

function cadastrarEstufa(nome, area, fkEmpresa, fkEndereco) {
  var instrucao = `
        INSERT INTO estufa (nome, area, fkEmpresa, fkEndereco) 
        VALUES ('${nome}', '${area}', '${fkEmpresa}', '${fkEndereco}');
    `;
  console.log("Executando a instrução SQL: \n" + instrucao);
  return database.executar(instrucao);
}

function qtdEstufas(idEmpresa) {
  var instrucao = `
    SELECT 
        idEstufa ID,
        estufa.nome Estufa,
        count(leituraSensor.valor) Valor
	        FROM estufa
        	JOIN setor ON estufa.idEstufa = setor.fkEstufa
        	JOIN subSetor ON setor.idSetor = subSetor.fkSetor
        	JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
        	JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor 
        	WHERE estufa.fkEmpresa = ${idEmpresa}
            GROUP BY idEstufa, estufa.nome;`;

  return database.executar(instrucao);
}

function listar() {
  console.log(
    "ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar()"
  );
  var instrucao = `
        SELECT * FROM estufa;
    `;
  console.log("Executando a instrução SQL: \n" + instrucao);
  return database.executar(instrucao);
}

function exibirEstufas(idUsuarioServer) {
  console.log("function da model", idUsuarioServer);
  var instrucao = `SELECT * FROM estufa join empresa on fkEmpresa = idEmpresa where idEmpresa = ${idUsuarioServer};`;
  return database.executar(instrucao);
}

function rankMaisAlertas(idUsuarioServer) {
  var instrucao = `
    SELECT COUNT(leituraSensor.idLeituraSensor) AS total_leituras, estufa.nome AS nome_estufa
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

function estadosEstufa(idEmpresa) {
  var instrucao = `
    SELECT e.idEstufa, a.tipo AS estado, COUNT(*) AS quantidade
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
    GROUP BY e.idEstufa, a.tipo
    ORDER BY e.idEstufa;
    `;

  return database.executar(instrucao);
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
  cadastrarEstufa,
  listar,
  exibirEstufas,
  rankMaisAlertas,
  qtdEstufas,
  estadosEstufa,
  pegarNome
};
