var medidaModel = require("../models/leituraModel");

function coletarMenorIndice (req, res) {
    var idEmpresa = req.params.idEmpresa;

    leituraModel.menorIndiceLuz(idEmpresa)
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
    var idEstufa = req.params.idEstufa;

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
    var idEmpresa = req.params.idAquario;

    console.log(`Recuperando medidas em tempo real`);
    medidaModel.buscarMedidasEmTempoReal(idEmpresa).then(function (resultado) {
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
    var idEmpresa = req.prams.idLeitura;

    console.log(`Buscando medidas de maior indice`);
    medidaModel.coletarMaiorIndice(idEmpresa).then(function (resultado) {
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
    coletarMenorIndice
}