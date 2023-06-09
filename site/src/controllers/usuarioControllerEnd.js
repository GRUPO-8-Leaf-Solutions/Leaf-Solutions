var usuarioEndModel = require("../models/usuarioEndModel");

var sessoes = [];

function testar(req, res) {
    console.log("ENTRAMOS NA usuarioControllerEND");
    res.json("ESTAMOS FUNCIONANDO!");
}

function cadastrarEnd(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var estado = req.body.estadoServer;
    var logradouro = req.body.logradouroServer;
    var complemento = req.body.complementoServer;
    var numEndereco = req.body.numEnderecoServer;
    var cidade = req.body.cidadeServer;
    var cep = req.body.cepServer;
    var bairro = req.body.bairroServer;
    // var fkEmpresa = req.body.fkEmpresaServer;

    // Faça as validações dos valores
    if (estado == undefined) {
        res.status(400).send("Seu estado está undefined!");
    } else if (logradouro == undefined) {
        res.status(400).send("Seu logradouro está undefined!");
    } else if (complemento == undefined) {
        res.status(400).send("Seu complemento está undefined!");
    } else if (numEndereco == undefined) {
        res.status(400).send("Seu numEndereco está undefined!");
    } else if (cidade == undefined) {
        res.status(400).send("Sua cidade está undefined!");
    } else if (cep == undefined) {
        res.status(400).send("Seu cep está undefined!");
    } else if (bairro == undefined) {
        res.status(400).send("Seu bairro está undefined!");
    } else {
        
        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioEndModel.cadastrarEnd(cep, logradouro, bairro, numEndereco, complemento, estado, cidade)
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

function selectEnd(req, res) {
    usuarioEndModel.selectEnd()
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

function listar(req, res) {
    usuarioEndModel.listar()
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

module.exports = {
    cadastrarEnd,
    testar,
    selectEnd,
    listar
}