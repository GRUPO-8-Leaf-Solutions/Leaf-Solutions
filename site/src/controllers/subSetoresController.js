var subSetoresModel = require("../models/subSetoresModel");

var sessoes = [];

function testar(req, res) {
    console.log("ENTRAMOS EM FUNCIONAMENTO");
    res.json("ESTAMOS FUNCIONANDO");
}

function buscarSubSetor(req, res) {
    console.log("socorro jesus do controller buscarsubsetor")
    var idSubSetor = req.body.idSubSetorServer;
    subSetoresModel.buscarSubSetor(idSubSetor)
        .then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum resultado encontrado")
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log("houve um erro ao buscar os SubSetores !");
            res.status(500).json(erro.sqlMessage)
        })
}


function buscarSensor(req, res) {
    var idSubSetor = req.body.idSubSetorServer
    subSetoresModel.buscarSensor(idSubSetor)
        .then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum resultado encontrado")
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log("houve um erro ao buscar os setores da estufa");
            res.status(500).json(erro.sqlMessage)
        })
}

function menorCaptacao(req, res) {
    subSetoresModel.buscarSensor(subSetor)
        .then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum resultado encontrado")
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log("houve um erro ao buscar a menor captação da estufa")
            req.status(500).json(erro.sqlMessage)
        })
}

function maiorCaptacao(req, res) {
    subSetoresModel.buscarSensor(subSetor)
        .then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum resultado encontrado")
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log("houve um erro ao buscar a maior captação da estufa")
            req.status(500).json(erro.sqlMessage)
        })
}

module.exports = {
    testar,
    buscarSubSetor,
    buscarSensor,
    menorCaptacao,
    maiorCaptacao
}
