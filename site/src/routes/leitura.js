    var express = require("express");
    var router = express.Router();

var leituraController = require("../controllers/leituraController");

router.post("/buscarUltimasMedidas", function (req, res) {
    leituraController.buscarUltimasMedidas(req, res);
});

router.get("/tempoReal/:idEmpresa", function (req, res) {
    leituraController.tempoReal(req, res);
})


router.post("/obterMenorIndice", function (req, res){
    leituraController.obterMenorIndice(req, res);
} )


router.post("/obterMaiorIndice", function (req, res){
    leituraController.obterMaiorIndice(req, res);
} )


router.post("/obterUltimasCapturasAlertas", function (req, res){
    leituraController.obterUltimasCapturasAlertas(req, res);
})

router.post("/obterSituacao", function (req, res){
    leituraController.obterSituacao(req, res);
})

module.exports = router;