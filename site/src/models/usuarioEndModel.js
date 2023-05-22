var database = require("../database/config")


function cadastrarEnd(cep, logradouro, numEndereco, complemento, estado, cidade, fkEmpresa) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():",estado, logradouro, complemento, numEndereco, cidade, cep);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.

    // informações de acordo com a tabela endereço do banco de dados  
    var instrucao = `
        INSERT INTO endereco (CEP, logradouro, numero, complemento, uf, cidade, fkEmpresa) VALUES ('${cep}', '${logradouro}', '${numEndereco}', '${complemento}', '${estado}', '${cidade}',  '${fkEmpresa}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function listar() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar()");
    var instrucao = `
        SELECT * FROM empresa;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}


module.exports = {
    cadastrarEnd,
    listar
};