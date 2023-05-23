var setoresModel = require("../models/setoresModel");

var sessoes = [];

function testar(req, res) {
    console.log("ENTRAMOS EM FUNCIONAMENTO");
    res.json("ESTAMOS FUNCIONANDO");
}

function qtdSetores(req, res) {
    var idUsuario = req.body.idUsuarioServer
    setoresModel.qtdSetores(idUsuario)
    console.log(`socorro jesus>>>>>>>>>>>>>>.....`, idUsuario)
        .then(function (resultado) {
            if (resultado.lenght > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("nenhum resultado encontrado")
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro os setores da estufa", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = {
    testar,
    qtdSetores,
}