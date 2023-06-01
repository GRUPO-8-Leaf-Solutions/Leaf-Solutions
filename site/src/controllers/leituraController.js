var leituraModel = require("../models/leituraModel");

function obterMenorIndice (req, res){
    var idEmpresa = req.body.idUsuarioServer

    leituraModel.obterMenorIndice(idEmpresa)
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

function obterMaiorIndice (req, res){
    var idEmpresa = req.body.idUsuarioServer

    leituraModel.obterMaiorIndice(idEmpresa)
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


function buscarUltimasMedidas(req, res) {
    const limite_linhas = 7;
    
    var idEmpresa = req.body.idUsuarioServer;
    var limiteLinhas = req.body.qtdEstufaServer

    console.log(`Recuperando as ultimas ${limite_linhas} medidas`);
    leituraModel.buscarUltimasMedidas(idEmpresa, limiteLinhas).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function tempoReal(req, res) {
    var idEmpresa = req.params.idEmpresa;

    console.log(`Recuperando medidas em tempo real`);
    leituraModel.tempoReal(idEmpresa)
    .then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}


function obterCaptacoes(req, res){
    var idEmpresa = req.body.idEmpresaServer;

    console.log(`Obtendo Captações`);
    leituraModel.obterCaptacoes(idEmpresa)

    // vai pro model e depois volta pro .then
    
    .then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).json("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao obter as captações para os alertas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    }); 
}

// function obterSituacao(req, res){
//     var idEmpresa = req.body.idEmpresaServer;

//     console.log(`Obtendo situacões das estufas`);
//     leituraModel.obterSituacao(idEmpresa)

//     // vai pro model e depois volta pro .then
    
//     .then(function (resultado) {
//         if (resultado.length > 0) {
//             res.status(200).json(resultado);
//         } else {
//             res.status(204).json("Nenhum resultado encontrado!")
//         }
//     }).catch(function (erro) {
//         console.log(erro);
//         console.log("Houve um erro ao obter as situações das estufas", erro.sqlMessage);
//         res.status(500).json(erro.sqlMessage);
//     }); 
// }



module.exports = {
    buscarUltimasMedidas,
    tempoReal,
    obterCaptacoes,
    obterMenorIndice,
    obterMaiorIndice, 
    // obterSituacao
}