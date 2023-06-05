var database = require("../database/config");

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

function login(email, senha) {
  console.log(
    "ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ",
    email,
    senha
  );

  var instrucao = `
        SELECT * FROM empresa WHERE email = '${email}' AND tokenPerm = '${senha}';
    `;

  console.log("Executando a instrução SQL: \n" + instrucao);
  return database.executar(instrucao);
}


function cadastrar(nome, email, cnpj) {

  var instrucao = `
        INSERT INTO empresa VALUES (null, '${cnpj}', '${nome}', '${email}', null);
       `;
  return database.executar(instrucao);
}

function cadUsuario(nome, sobreNome, email, senha, empresa) {
  console.log(
    "ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():",
    nome,
    sobreNome,
    email,
    senha,
    empresa
  );

  var instrucao = `
        INSERT INTO usuario (nome, sobrenome, email, senha, fkEmpresa) VALUES ('${nome}', '${sobreNome}', '${email}', '${senha}', '${empresa}');
       `;
  console.log("Executando a instrução SQL: \n" + instrucao);
  return database.executar(instrucao);
}

module.exports = {
  login,
  cadastrar,
  listar,
  cadUsuario,
};
