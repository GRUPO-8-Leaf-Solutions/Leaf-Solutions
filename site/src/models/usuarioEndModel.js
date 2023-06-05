var database = require("../database/config");

function cadastrarEnd(
  cep, logradouro, bairro, numEndereco, complemento, estado, cidade,
) {
 
  var instrucao = `
        INSERT INTO endereco
        (CEP, logradouro, bairro, numero, complemento, uf, cidade) 
        VALUES 
        ('${cep}', '${logradouro}', '${bairro}', '${numEndereco}', '${complemento}', '${estado}', '${cidade}');
    `;
  return database.executar(instrucao);
}

function selectEnd() {

  var instrucao = `
        SELECT max(idEndereco) as ultimoIdCadastrado
        FROM endereco;
    `;
  return database.executar(instrucao);

}

function listar() {
  console.log(
    "ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar()"
  );
  var instrucao = `
        SELECT * FROM empresa;
    `;
  console.log("Executando a instrução SQL: \n" + instrucao);
  return database.executar(instrucao);
}

module.exports = {
  cadastrarEnd,
  listar,
  selectEnd,
};
