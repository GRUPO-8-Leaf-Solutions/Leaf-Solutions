var usuarioEstufaModel = require("../models/usuarioEstufaModel");   

var sessoes = [];

function testar(req, res) {
    console.log("ENTRAMOS NA usuarioEstufaModel");
    res.json("ESTAMOS FUNCIONANDO!");
}

function cadastrarEstufa(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var nome = req.body.nomeServer;
    var area = req.body.areaServer;
    // var complemento = req.body.complementoServer;
    // var numEndereco = req.body.numEnderecoServer;
    // var cidade = req.body.cidadeServer;
    // var cep = req.body.cepServer;

    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("Seu nome da estufa está undefined!");
    } else if (area == undefined) {
        res.status(400).send("Sua área está undefined!");
    // } else if (complemento == undefined) {
    //     res.status(400).send("Seu complemento está undefined!");
    // } else if (numEndereco == undefined) {
    //     res.status(400).send("Seu numEndereco está undefined!");
    // } else if (cidade == undefined) {
    //     res.status(400).send("Sua cidade está undefined!");
    // } else if (cep == undefined) {
    //     res.status(400).send("Seu cep está undefined!");
    // }
    } else {

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioEstufaModel.cadastrarEstufa(nome, area)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

function listar(req, res) {
    usuarioEstufaModel.listar()
        .then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum resultado encontrado!")
            }
        }).catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao realizar a consulta! Erro: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function exibirEstufas(req, res) {
    console.log("function da controller", idUsuarioServer)
    usuarioEstufaModel.exibirEstufas(req.body.idUsuarioServer)
    .then(function (resultado) {
        if(resultado.length > 0) {
            res.status(200).json(resultado);
        } else { 
            res.status(204).send("nenhum resultado encontrado!")
        }
}).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar as estufas da empresa..", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
});
}

module.exports = {
    cadastrarEstufa,
    testar,
    listar,
    exibirEstufas
}