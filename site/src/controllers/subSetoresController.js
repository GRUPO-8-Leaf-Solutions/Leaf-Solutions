var subSetoresModel = require("../models/subSetoresModel");

var sessoes = [];

function testar(req, res) {
    console.log("ENTRAMOS EM FUNCIONAMENTO");
    res.json("ESTAMOS FUNCIONANDO");
}

function buscarSubSetor(req, res) {
    console.log("socorro jesus do controller buscarsubsetor")
    var idSetor = req.body.idSetorServer;
    subSetoresModel.buscarSubSetor(idSetor)
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


function obterMenorIndice(req, res) {
    console.log("to no controller")
    var idEmpresa = req.body.idUsuarioServer;
    var idSetor = req.body.idSetorServer;
    var idEstufa = req.body.idEstufaServer;
    var idSubSetor = req.body.idSubSetorServer;
    var idSensor = req.body.idSensorServer;

    subSetoresModel.obterMenorIndice(idEmpresa, idSensor, idSubSetor, idEstufa, idSetor)
        .then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("nenhum resultado encontrado!")
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao buscar os Menores indice da da estufa..", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

function obterMaiorIndice(req, res) {
    console.log("to no controller 2")
    var idEmpresa = req.body.idUsuarioServer;
    var idSetor = req.body.idSetorServer;
    var idEstufa = req.body.idEstufaServer;
    var idSubSetor = req.body.idSubSetorServer;
    var idSensor = req.body.idSensorServer;

    subSetoresModel.obterMaiorIndice(idEmpresa, idSensor, idSubSetor, idEstufa, idSetor)
        .then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("nenhum resultado encontrado!")
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao buscar os Maiores indice da da estufa..", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

function obterIndiceAtual(req, res) {
    console.log("to no controller 3")
    var idEmpresa = req.body.idUsuarioServer;
    var idSetor = req.body.idSetorServer;
    var idEstufa = req.body.idEstufaServer;
    var idSubSetor = req.body.idSubSetorServer;
    var idSensor = req.body.idSensorServer;

    subSetoresModel.obterIndiceAtual(idEmpresa, idEstufa, idSetor, idSubSetor, idSensor)
        .then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("nenhum resultado encontrado!")
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao buscar os Maiores indice da da estufa..", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

// function obterMenorIndice(req, res) {

//     var idEmpresa = req.body.idUsuarioServer;
//     var idSetor = req.body.idSetorServer;
//     var idEstufa = req.body.idEstufaServer;
//     var idSubSetor = req.body.idSubSetorServer;
//     var idSensor = req.body.idSensorServer;
//     subSetoresModel.obterMenorIndice(idEmpresa, idSensor, idSubSetor, idEstufa, idSetor)
//         .then(function (resultado) {
//             if (resultado.length > 0) {
//                 res.status(200).json(resultado);
//             } else {
//                 res.status(204).send("nenhum resultado encontrado!")
//             }
//         }).catch(function (erro) {
//             console.log(erro);
//             console.log("Houve um erro ao buscar as estufas da empresa..", erro.sqlMessage);
//             res.status(500).json(erro.sqlMessage);
//         });
// }

// function obterMaiorIndice(req, res) {
//     var idEmpresa = req.body.idUsuarioServer

//     subSetoresModel.obterMaiorIndice(idEmpresa)
//         .then(function (resultado) {
//             if (resultado.length > 0) {
//                 res.status(200).json(resultado);
//             } else {
//                 res.status(204).send("nenhum resultado encontrado!")
//             }
//         }).catch(function (erro) {
//             console.log(erro);
//             console.log("Houve um erro ao buscar as estufas da empresa..", erro.sqlMessage);
//             res.status(500).json(erro.sqlMessage);
//         });
// }

module.exports = {
    testar,
    buscarSubSetor,
    buscarSensor,
    obterMenorIndice,
    obterMaiorIndice,
    obterIndiceAtual
}
