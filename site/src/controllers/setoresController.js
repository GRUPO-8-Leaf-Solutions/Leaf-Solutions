var setoresModel = require("../models/setoresModel");

var sessoes = [];

function testar(req, res) {
    console.log("ENTRAMOS EM FUNCIONAMENTO");
    res.json("ESTAMOS FUNCIONANDO");
}

function exibirQtdSetores(req, res){
    setoresModel.exibirQtdSetores(req.body.idUsuarioServer)
    .then(function (resultado) {
        if(resultado.length > 0){
            res.status(200).json(resultado);
        }else {
            res.status(204).send("Nenhum resultado encontrado")
        }
    }).catch(function (erro){
        console.log(erro);
        console.log("houve um erro ao buscar os setores da estufa");
        res.status(500).json(erro.sqlMessage)
    })
}

function obterSetores(req, res){
    setoresModel.obterSetores(req.body.idUsuarioServer)
    .then(function (resultado) {
        if(resultado.length > 0){
            res.status(200).json(resultado);
        }else {
            res.status(204).send("Nenhum resultado encontrado")
        }
    }).catch(function (erro){
        console.log(erro);
        console.log("houve um erro ao buscar os setores da estufa");
        res.status(500).json(erro.sqlMessage)
    })
}

module.exports = {
    testar,
    exibirQtdSetores,
    obterSetores
}