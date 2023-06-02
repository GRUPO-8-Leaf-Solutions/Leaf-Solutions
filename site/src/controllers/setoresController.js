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

// function buscarUltimasMedidas(req, res) {
//     const limite_linhas = 7;
//     var idEstufa = req.params.idEstufa;

//     console.log(`Recuperando as ultimas ${limite_linhas} medidas`);
//     leituraModel.buscarUltimasMedidas(idEmpresa, limite_linhas).then(function (resultado) {
//         if (resultado.length > 0) {
//             res.status(200).json(resultado);
//         } else {
//             res.status(204).send("Nenhum resultado encontrado!")
//         }
//     }).catch(function (erro) {
//         console.log(erro);
//         console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
//         res.status(500).json(erro.sqlMessage);
//     });
// }

// function buscarSubSetor(req, res){
//     setoresModel.buscarSubSetor(req.body.idSubSetorServer)
//     .then(function (resultado) {
//         if(resultado.length > 0){
//             res.status(200).json(resultado);
//         }else {
//             res.status(204).send("Nenhum resultado encontrado")
//         }
//     }).catch(function (erro){
//         console.log(erro);
//         console.log("houve um erro ao buscar os SubSetores !");
//         res.status(500).json(erro.sqlMessage)
//     })
// }


// function buscarSensor(req, res){
//     setoresModel.buscarSensor(req.body.idSubSetorServer)
//     .then(function (resultado) {
//         if(resultado.length > 0){
//             res.status(200).json(resultado);
//         }else {
//             res.status(204).send("Nenhum resultado encontrado")
//         }
//     }).catch(function (erro){
//         console.log(erro);
//         console.log("houve um erro ao buscar os setores da estufa");
//         res.status(500).json(erro.sqlMessage)
//     })
// }


module.exports = {
    testar,
    exibirQtdSetores,
    obterSetores
    // buscarSubSetor,
    // buscarSensor
}