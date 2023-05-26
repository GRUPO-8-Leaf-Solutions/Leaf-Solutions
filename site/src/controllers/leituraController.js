var leituraModel = require("../models/leituraModel");

function coletarMenorIndice (req, res) {
    var idEmpresa = req.body.idEmpresa;

    leituraModel.coletarMenorIndice(idEmpresa)
        .then(function (resultado) {
            if(resultado.length > 0) {
                res.status(200).json(resultado);
            } else { 
                res.status(204).send("nenhum resultado encontrado!")
            }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}


function buscarUltimasMedidas(req, res) {
    const limite_linhas = 7;
    var idEmpresa = req.params.idEmpresa;

    console.log(`Recuperando as ultimas ${limite_linhas} medidas`);
    leituraModel.buscarUltimasMedidas(idEmpresa, limite_linhas).then(function (resultado) {
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

function buscarMedidasEmTempoReal(req, res) {
    var idEmpresa = req.params.idEmpresa;

    console.log(`Recuperando medidas em tempo real`);
    leituraModel.buscarMedidasEmTempoReal(idEmpresa).then(function (resultado) {
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

function coletarMaiorIndice(req, res) {
    var idEmpresa = req.body.idEmpresa;

    console.log(`Buscando medidas de maior indice`);
    leituraModel.coletarMaiorIndice(idEmpresa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).json("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as medidas com o maior indice.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    }); 

}

function exibirAlertas(req, res){
    var idEmpresa = req.body.idEmpresa;

    console.log(`Procurando ultimos alertas`);
    leituraModel.exibirAlertas(idEmpresa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).json("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as medidas com o maior indice.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    }); 
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    coletarMaiorIndice,
    coletarMenorIndice,
    exibirAlertas
}